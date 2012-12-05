Yet Another Keyring Gem
=======================

Storing passwords in plaintext makes me a sad panda. Let's use Apple's
Keychain utility!

```
tmaher@bananaweizen:~$ irb
irb(main):001:0> require 'yakg'
=> true
irb(main):002:0> Yakg.set "someuser", "s3|<r1+"
=> true
irb(main):003:0> Yakg.get "someuser"
=> "s3|<r1+"
irb(main):004:0> Yakg.unset "someuser"
=> true
irb(main):005:0> Yakg.get "someuser"
=> nil
irb(main):006:0> Yakg.set "user1", "password1"
=> true
irb(main):007:0> Yakg.set "user2", "2password"
=> true
irb(main):008:0> Yakg.list
=> ["user1", "user2"]
```

In addition to usernames, Keychain also has the notion of "service
name". It's a free-form string, useful for namespacing different
accounts.  Let's take a look...

```
rb(main):009:0> Yakg.DEFAULT_SERVICE_NAME
=> "ruby-yakg-gem"
irb(main):010:0> Yakg.DEFAULT_SERVICE_NAME = "awesome other service"
=> "awesome other service"
irb(main):011:0> Yakg.list
=> []
irb(main):012:0> Yakg.set "user1", "kitties!"
=> true
irb(main):013:0> Yakg.set "harry.bovik", "dogs"
=> true
irb(main):014:0> Yakg.list
=> ["user1", "harry.bovik"]
irb(main):015:0> Yakg.list "ruby-yakg-gem"
=> ["user1", "user2"]
irb(main):016:0> Yakg.get "user1", "ruby-yakg-gem"
=> "password1"
irb(main):017:0> Yakg.get "user1"
=> "kitties!"
irb(main):018:0> ^D
tmaher@bananaweizen:~$ irb
irb(main):001:0> require 'yakg'
=> true
irb(main):002:0> Yakg.list
=> ["user1", "user2"]
irb(main):003:0> Yakg.list "awesome other service"
=> ["user1", "harry.bovik"]
irb(main):004:0> Yakg.list
=> ["user1", "user2"]
irb(main):005:0> Yakg.unset "user1"
=> true
irb(main):006:0> Yakg.list
=> ["user2"]
irb(main):007:0> Yakg.list "awesome other service"
=> ["user1", "harry.bovik"]
```

Technical Details
=================

This gem wrapps Apple's Security Framework (a C library) using the
excellent `ffi` gem. References for the full Keychain Services API can
be found at
https://developer.apple.com/library/mac/#documentation/security/Reference/keychainservices/Reference/reference.html

My views on the virtues of wrapping Security Framework and calling it
from the Ruby process, as opposed to use of helper programs such as
`git-password`, can be found at https://gist.github.com/4116645


Related Work
============

* https://github.com/xli/mac-keychain also wraps Security Framework
  but with RubyCocoa. That makes it more difficult to use with local
  Ruby builds

* https://github.com/seattlerb/osx_keychain uses RubyInline to call
  into the underlying C library. That necessitates a C compiler.

* https://github.com/jprichardson/keychain_manager shells out to call
  the `security` CLI tool.  It's also less oriented around password
  management, and more geared towards PKI.

* https://github.com/fcheung/keychain also wraps Security Framework
  with ffi.  It's far more feature-complete than Yakg, but I wanted a
  more minimalist API. Both approaches absolutely have their place.
  Yakg shares some code, specifically fcheung/corefoundation for error
  message string handling, and I am indebted to Mr. Cheung for it.
