require 'find'

Gem::Specification.new do |s|
  s.name = 'yakg'
  s.version = File.read("VERSION").chomp
  s.summary = 'Yet Another Keyring Gem'
  s.description = "Use FFI to access the MacOS Keychain"
  s.authors = ["Tom Maher"]
  s.email = "tmaher@pw0n.me"
  s.license = "Apache 2.0"
  s.files = `git ls-files`.split("\n")
  s.homepage = "https://github.com/tmaher/yakg"
  s.add_development_dependency "woof_util", '~>0'
  s.add_development_dependency "rake", '~>2'
  s.add_development_dependency "rspec", '~>3'
end
