#!/usr/bin/env ruby

srcdir = File.realpath "#{__FILE__}/../../"
require "#{srcdir}/lib/yakg"

Yakg.DEFAULT_SERVICE_NAME = "yakg-test"
Yakg.set "somekey", "someval"
puts Yakg.get "somekey"
