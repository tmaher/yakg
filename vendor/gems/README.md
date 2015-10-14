Yo dog, I hear you like vendoring...
====================================

While yakg itself is pure Ruby, it does rely on ffi (a native gem) to
call into Apple Keychain and Microsoft's DPAPI & Registry.  Heroku
Toolkit for Windows vendors in ffi, but we don't for MacOS X doesn't,
and it's kinda sucky to require people to install XCode/gcc just for
one gem.  The corefoundation gem is also included, because it has an
explicit ffi dependency.

Consequently, yakg itself vendors in ffi, including the ffi_c.bundle
shared object. Versions are included for Ruby ABIs 1.8, 1.9.1
(includes 1.9.2 & 1.9.3), and 2.0.0. All are compiled as universal
binaries. `installit.sh` is the helper script, but only does them one
at a time. Given how long each ruby compile takes, and how everyone's
rbenv & homebrew installs are their own beautiful unique snowflake,
I'm reluctant to script this out too much, but my notes are at the
bottom.

If you already have a compiler and ffi installed, the gem load path
evil that I do in `lib/yakg.rb` should be using that instead.

Doing the same thing for Windows is left as an exercise to the reader.

ffi_c.bundle recompilation notes
================================

```
$ brew update; brew uninstall openssl
$ brew install openssl --universal
$ cd ~/.rbenv/
$ mv versions stash_versions
$ for RUBY_VERSION in 2.0.0-p247 2.1.7 2.2.3; do
> CC="xcrun cc" CPP="xcrun cc -E" \
    RUBY_CONFIGURE_OPTS="--with-arch=x86_64,i386 \
    --with-openssl-dir=/usr/local/opt/openssl" \
    rbenv install $RUBY_VERSION
> rbenv global $RUBY_VERSION
> gem install bundler
> pushd ~/src/yakg
> bundle install --path vendor
> popd
> done
$ mv versions clean_universal_builds
$ mv stash_versions versions 


```
$ rbenv global system
$ ./installit.sh
$ CC="xcrun cc" CPP="xcrun cc -E" \
  RUBY_CONFIGURE_OPTS="--with-arch=x86_64,i386" \
  rbenv install 1.9.3-p392
... stuff happens ...
$ rbenv global 1.9.3-p392
$ ./installit.sh
# this sucks - Mountain Lion ships with openssl 0.9.8, which is both
# old and doesn't work with ruby 2.0.0
$ brew install openssl
# and then we have to recompile it as a fat binary to make
# 2.0.0 compile-able as a fat binary...
$ ./build_openssl_dylib.sh
$ CC="xcrun cc" CPP="xcrun cc -E" \
  RUBY_CONFIGURE_OPTS="--with-arch=x86_64,i386 --with-openssl-dir=/usr/local/opt/openssl" \
  rbenv install 2.0.0-p0
... stuff happens ...
$ rbenv global 2.0.0-p0
$ ./installit.sh
```
