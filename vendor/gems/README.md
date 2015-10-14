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
$ cd ~/src/yakg
$ for RUBY_VERSION in 2.0.0-p247 2.1.7 2.2.3; do
  > CC="xcrun cc" CPP="xcrun cc -E" \
      RUBY_CONFIGURE_OPTS="--with-arch=x86_64,i386 \
      --with-openssl-dir=/usr/local/opt/openssl" \
      rbenv install $RUBY_VERSION
  > rbenv global $RUBY_VERSION
  > gem install bundler
  > bundle install --path vendor
  > done
$ cd vendor/gems
$ for ABI in 2.1.0 2.2.0; do
  > mkdir -p ${ABI}/gems ${ABI}/specifications
  > cp ../ruby/$ABI/specifications/{corefoundation,ffi}-* ${ABI}/specifications
  > rsync -avP ../ruby/${ABI}/gems/{corefoundation,ffi}-* ${ABI}/gems
  > pushd ${ABI}/gems/ffi-*
  > mv ext/ffi_c/ffi_c.bundle lib
  > popd
  > rm -rf ${ABI}/gems/{corefoundation,ffi}-*/{ext,spec}
  > done
$ mv versions clean_universal_builds
$ mv stash_versions versions
```
