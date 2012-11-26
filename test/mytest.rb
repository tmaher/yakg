#!/usr/bin/env ruby

require "rubygems"
require "bundler/setup"
require "lib/yakg"

Yakg.DEFAULT_SERVICE_NAME = "yakg-rspec"
Yakg.list.each {|x| Yakg.unset x }

exit 0
