#!/usr/bin/env ruby

srcdir = File.realpath "#{__FILE__}/../../"
require "#{srcdir}/lib/yakg"

Yakg.DEFAULT_SERVICE_NAME = "bob"
puts Yakg.DEFAULT_SERVICE_NAME
