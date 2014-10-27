# Crackpot

**Easily crack your GnuPG keys or encrypted files using a brute-force attack via
dictionaries**. Default dictionary uses the top 10000 passwords of all
time as an initial attempt. More dictionaries can be specified on
runtime.

### WARNING: in active development

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'crackpot'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install crackpot

## Usage

To decrypt a GPG key or encrypted file (e.g. `somefile.gpg`), simply, run the following command in your terminal:

    # uses the default (top 10000 passwords) list for passphrase searching:
    crackpot gpg somefile.gpg

    # use a specified word list for passphrase searching:
    crackpot gpg somefile.gpg --lists=/path/to/wordslist
    crackpot gpg somefile.gpg --lists=/path/to/wordslist /path/to/wordlist2

    # do not print any progress bars, etc. (be very quiet)
    crackpot gpg somefile.gpg --quiet
    # will print: 2343 secretphrase
    # where, 2343 is the total number of password that were tried.

## TODO

- Add a screenshot.
- Add tests.
- Do not save WordList along with the gem, and instead, allow to
  download them when the user runs the command for the first time.
- Extract terminal UI (and debug) related code in `lib/crackpot/gpg.rb`
  to `bin/crackpot`.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/crackpot/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
