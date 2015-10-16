Yo dog, I hear you like vendoring...
====================================

While yakg itself is pure Ruby, it does rely on ffi (a native gem) to
call into Apple Keychain and Microsoft's DPAPI & Registry.  It's kinda
sucky to require people to install XCode/gcc just for one gem. The
corefoundation gem is also included, because it has an explicit ffi
dependency.

Consequently, yakg itself vendors in ffi, including the ffi_c.bundle
shared object. Versions are included for Ruby ABIs 1.8 through 2.2.0.
All are compiled as universal binaries. If you already have a compiler
and ffi installed, the gem load path evil that I do in `lib/yakg.rb`
should be using that instead.

Doing the same thing for Windows is left as an exercise to the reader.

ffi_c.bundle recompilation notes
================================
Note, `vendor/gems` is tracked in the repo. `vendor/alice` is a scratch
space.

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
  > bundle install --path vendor/alice
  > done
$ cd vendor/alice
$ for ABI in 2.1.0 2.2.0; do
  > mkdir -p ../gems/ruby/${ABI}/gems
  > mkdir -p ../gems/ruby/${ABI}/extensions/x86_64-darwin-15
  > mkdir -p ../gems/ruby/${ABI}/specifications
  > rsync -avP ruby/${ABI}/gems/{corefoundation,ffi}-* ../gems/ruby/${ABI}/gems/
  > pushd ruby/${ABI}/extensions/universal-darwin-15
  > rsync -avP * ../x86_64-darwin-15
  > popd
  > rsync -avP ruby/${ABI}/extensions ../gems/ruby/${ABI}/
  > cp ruby/${ABI}/specifications/{corefoundation,ffi}-* \
    ../gems/ruby/${ABI}/specifications/
  > done
$ mv versions clean_universal_builds
$ mv stash_versions versions
```
