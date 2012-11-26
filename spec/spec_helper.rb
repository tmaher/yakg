require 'rubygems'
require 'bundler/setup'

$: << File.dirname(__FILE__) + '/../lib'

require 'yakg'
Yakg.DEFAULT_SERVICE_NAME = "yakg-rspec"
require 'securerandom'

RSpec.configure do |config|
  config.color_enabled = true

  # Use color not only in STDOUT but also in pagers and files
  config.tty = true

  # Use the specified formatter
  #config.formatter = :documentation # :progress, :html, :textmate
end
