#!/bin/bash -x

if [ "x$1" = "appleruby" ]; then
    export PATH="/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/bin:/usr/local/sbin"
fi
DIR="$( cd "$( dirname "$0" )" && pwd )" ; cd $DIR

if ! [ -r `basename $0 2>/dev/null` ]; then
    echo "FAIL! can't cd to the parent of $0"
    exit 1
fi

export RUBY_ABI_VERSION=`ruby --version | cut -d \  -f 2 | cut -d . -f 1-2`

if [ "x${RUBY_ABI_VERSION}" = "x" ]; then
    echo "FAIL!  can't figure out ruby version"
    exit 2
fi

if echo ${RUBY_ABI_VERSION} 2>/dev/null | grep "^1\.8" 2>/dev/null; then
    export RUBY_ABI_VERSION=1.8
elif echo ${RUBY_ABI_VERSION} 2>/dev/null | grep "^1\.9" 2>/dev/null; then
    export RUBY_ABI_VERSION=1.9.1
elif echo ${RUBY_ABI_VERSION} 2>/dev/null | grep "^2\.0" 2>/dev/null; then
    export RUBY_ABI_VERSION=2.0.0
fi

rm -rf Gemfile.lock "ruby/${RUBY_ABI_VERSION}"
bundle install --path `pwd`

FFI_C=`find ruby/${RUBY_ABI_VERSION} -type f -name ffi_c.bundle | head -n 1`
if [ "x${FFI_C}" = "x" ]; then
    echo "FAIL!  Couldn't install ffi"
    exit 3
fi

CFRB=`find ruby/${RUBY_ABI_VERSION} -type f -name corefoundation.rb | head -n 1`
if [ "x${CFRB}" = "x" ]; then
    echo "FAIL!  Couldn't install corefoundation"
    exit 4
fi

rm -rf ./ruby/${RUBY_ABI_VERSION}/gems/ffi-*/{ext,spec}
rm -rf ./ruby/${RUBY_ABI_VERSION}/cache
