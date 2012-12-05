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

