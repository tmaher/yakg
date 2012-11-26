require 'find'

Gem::Specification.new do |s|
  s.name = 'yakg'
  s.version = File.read("VERSION").chomp
  s.date = '2012-11-25'
  s.summary = 'Yet Another Keyring Gem'
  s.description = "Use Ruby's DL mechanism to access the MacOS Keychain"
  s.authors = ["Tom Maher"]
  s.email = "tmaher@tursom.org"
  s.files = []
  File.find "lib" do |f|
    s.files.push(f) if FileTest.file? f
  end
  s.homepage = "https://github.com/tmaher/yakg"
end
  
