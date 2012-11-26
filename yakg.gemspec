require 'find'

Gem::Specification.new do |s|
  s.name = 'yakg'
  s.version = File.read("VERSION").chomp
  s.date = '2012-11-25'
  s.summary = 'Yet Another Keyring Gem'
  s.description = "Use Ruby's DL mechanism to access the MacOS Keychain"
  s.authors = ["Tom Maher"]
  s.email = "tmaher@tursom.org"
  s.files = `git ls-files`.split("\n")
  s.homepage = "https://github.com/tmaher/yakg"
  s.add_dependency "ffi"
  s.add_dependency "corefoundation"
  s.add_development_dependency "woof_util"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
end
