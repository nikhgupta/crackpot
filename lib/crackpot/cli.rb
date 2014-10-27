module Crackpot
  class CLI < Thor
    desc "gpg [ENCRYPTED_FILE]", "crack a gpg encrypted file for passphrase"
    method_option :lists, type: :array, default: {}, desc: "word lists to use"
    method_option :quiet, type: :boolean, default: false
    def gpg encrypted_file
      Crackpot::GPG.new(encrypted_file, options).run
    end
  end
end
