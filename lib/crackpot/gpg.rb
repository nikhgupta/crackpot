module Crackpot
  class GPG
    attr_accessor :file, :lists

    def initialize file, options = {}
      self.file    = file
      self.options = options
    end

    def options=(options = {})
      @options = options
      self.lists = options[:lists]
    end

    def lists=(lists = [])
      lists_dir = File.join(File.dirname(__FILE__), "..", "..", "share", "lists")
      @lists = lists.any? ? lists : Dir.glob(File.join(lists_dir, "*.txt"))
    end

    def phrase_count
      %x[ cat '#{lists.join("' '")}' | wc -l ].strip.to_i
    end

    def try_passphrase phrase
      command = "gpg --passphrase \"#{phrase.shellescape}\" --no-tty --decrypt #{@file}"
      @last_response = %x[ #{command} 2> /dev/null ]
      @phrase = phrase unless @last_response.nil? || @last_response.empty?
    end

    def found?
      !@phrase.nil? && !@phrase.empty?
    end

    def try_phrases_in_list file
      # title = File.basename(file, File.extname(file)).split("_")
      # title.shift
      # @pbar.log "-- Processing: #{title.join(" ").upcase}"

      phrases = File.readlines(file).map(&:strip)
      phrases.detect do |phrase|
        try_passphrase phrase
        if @pbar
          @pbar.increment
        else
          @counter += 1
        end
        found?
      end
    end

    def run
      if @options["quiet"]
        @counter = 0
      else
        puts "=> Started GPG cracker at: #{Time.now}"
        puts "=> Total keys in database: #{phrase_count}\n\n"

        @pbar = ProgressBar.create(
          title: "Tried", total: nil,
          format: "[%t: %c] %B %a [%r keys/min]",
          rate_scale: lambda{|rate|rate*60}
        )
      end
      lists.detect{ |file| try_phrases_in_list(file) }
      @pbar.stop if @pbar

      if @phrase && !@options["quiet"]
        puts "\n-- Message: --------------------------------"
        puts @last_response
        puts "--------------------------------------------"
        puts "\n\n\t[ KEY FOUND: #{@phrase} ]\n\n\n"
      elsif @phrase
        puts "#{@counter} #{@phrase}"
      elsif !@options["quiet"]
        puts "\n[FAILED] Could not find your passphrase."
        puts "Perhaps, you can provide me with a better word list?"
      end
    rescue Interrupt
      puts; puts
      puts "Good bye."
    end
  end
end
