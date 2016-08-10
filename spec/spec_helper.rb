require 'rubygems'
require 'bundler/setup'
require 'fiddle'

$: << File.dirname(__FILE__) + '/../lib'

require 'yakg'
Yakg.DEFAULT_SERVICE_NAME = "yakg-rspec"
require 'securerandom'

RSpec.configure do |config|
  config.tty = true
  config.raise_errors_for_deprecations!

  # Use the specified formatter
  #config.formatter = :documentation # :progress, :html, :textmate
end
