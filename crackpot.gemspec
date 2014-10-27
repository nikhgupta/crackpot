# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'crackpot/version'

Gem::Specification.new do |spec|
  spec.name          = "crackpot"
  spec.version       = Crackpot::VERSION
  spec.authors       = ["Nikhil Gupta"]
  spec.email         = ["me@nikhgupta.com"]
  spec.summary       = %q{Gem that helps in cracking passphrases for GPG keys.}
  spec.description   = %q{Gem that helps in cracking passphrases for GPG keys.}
  spec.homepage      = "https://github.com/nikhgupta/crackpot"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"

  spec.add_dependency "thor"
  spec.add_dependency "ruby-progressbar"
end
