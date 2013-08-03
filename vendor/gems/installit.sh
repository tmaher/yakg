#!/bin/bash -x

set -e

export R200="2.0.0-p195"
export R191="1.9.3-p448"
export R18="1.8.7-p374"

cd ${HOME}/heroku/yakg/vendor/gems/ruby
git rm -r *
rm -rf *
mkdir -p x86_64/2.0.0 x86_64/1.9.1 x86_64/1.8 i386/2.0.0 i386/1.9.1 i386/1.8

pushd ${HOME}/.rbenv/versions
ln -sf x86_64-${R200} ${R200}
ln -sf x86_64-${R191} ${R191}
ln -sf x86_64-${R18} ${R18}
popd

pushd x86_64

echo ${R200} > ${HOME}/.rbenv/version
gem install ffi corefoundation -i ./2.0.0
pushd 2.0.0
rm -rf cache doc
pushd gems
rm -rf */spec */ext */libtest
popd
popd

echo ${R191} > ${HOME}/.rbenv/version
gem install ffi corefoundation -i ./1.9.1
pushd 1.9.1
rm -rf cache doc
pushd gems
rm -rf */spec */ext */libtest
popd
popd

echo ${R18} > ${HOME}/.rbenv/version
gem install ffi corefoundation -i ./1.8
pushd 1.8
rm -rf cache doc
pushd gems
rm -rf */spec */ext */libtest
popd
popd

popd

pushd ${HOME}/.rbenv/versions
ln -sf i386-${R200} ${R200}
ln -sf i386-${R191} ${R191}
ln -sf i386-${R18} ${R18}
echo ${R191} > ../version
popd


pushd i386


echo ${R200} > ${HOME}/.rbenv/version
gem install ffi corefoundation -i ./2.0.0
pushd 2.0.0
rm -rf cache doc
pushd gems
rm -rf */spec */ext */libtest
popd
popd

echo ${R191} > ${HOME}/.rbenv/version
gem install ffi corefoundation -i ./1.9.1
pushd 1.9.1
rm -rf cache doc
pushd gems
rm -rf */spec */ext */libtest
popd
popd

echo ${R18} > ${HOME}/.rbenv/version
gem install ffi corefoundation -i ./1.8
pushd 1.8
rm -rf cache doc
pushd gems
rm -rf */spec */ext */libtest
popd
popd

popd

mv x86_64/* .
rmdir x86_64

lipo i386/2.0.0/gems/ffi-*/lib/ffi_c.bundle 2.0.0/ffi-*/lib/ffi_c.bundle \
    -create -output 2.0.0/ffi-*/lib/ffi_c_universal.bundle
lipo i386/1.9.1/gems/ffi-*/lib/ffi_c.bundle 1.9.1/ffi-*/lib/ffi_c.bundle \
    -create -output 1.9.1/ffi-*/lib/ffi_c_universal.bundle
lipo i386/1.8/gems/ffi-*/lib/ffi_c.bundle 1.8/ffi-*/lib/ffi_c.bundle \
    -create -output 1.8/ffi-*/lib/ffi_c_universal.bundle

rm */ffi-*/lib/ffi_c.bundle

pushd 2.0.0/ffi-*/lib
mv ffi_c_universal.bundle ffi_c.bundle
popd
pushd 1.9.1/ffi-*/lib
mv ffi_c_universal.bundle ffi_c.bundle
popd
pushd 1.8/ffi-*/lib
mv ffi_c_universal.bundle ffi_c.bundle
popd
