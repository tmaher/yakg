#!/usr/bin/env ruby

require "rubygems"
require "bundler/setup"

srcdir = File.expand_path "#{__FILE__}/../../"
require "#{srcdir}/lib/yakg"

Yakg.DEFAULT_SERVICE_NAME = "yakg-test"
puts Yakg.get "somekey"

Yakg.set "otherkey", "s3kr1t"
puts Yakg.get "otherkey"

Yakg.unset "otherkey"
puts "deleted?: #{Yakg.get("otherkey").nil?}"
