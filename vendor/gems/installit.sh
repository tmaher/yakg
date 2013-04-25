#!/bin/bash -x

# default mac os path
export PATH="/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/bin:/usr/local/sbin"
DIR="$( cd "$( dirname "$0" )" && pwd )" ; cd $DIR

if ! [ -r `basename $0 2>/dev/null` ]; then
    echo "FAIL! can't cd to the parent of $0"
    exit 1
fi

if [ -r ruby ] && ! [ -d ruby ]; then
    echo "FAIL! ./ruby exists and is not a directory"
    exit 2
fi

rm -rf Gemfile.lock ruby
bundle install --path `pwd`

FFI_C=`find ruby -type f -name ffi_c.bundle | head -n 1`
if [ "x${FFI_C}" = "x" ]; then
    echo "FAIL!  Couldn't install ffi"
    exit 3
fi

CFRB=`find ruby -type f -name corefoundation.rb | head -n 1`
if [ "x${CFRB}" = "x" ]; then
    echo "FAIL!  Couldn't install corefoundation"
    exit 4
fi

rm -rf ./ruby/*/gems/ffi-*/{ext,spec}
rm -rf ./ruby/*/cache
