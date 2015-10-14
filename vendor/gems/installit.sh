#!/bin/bash -x

export R18="system"
export R191="1.9.3-p448"
export R200="2.0.0-p195"
export R210="2.1.7"
export R210="2.2.3"

export FFI_VER="1.9.10"

export GEM_CMD="gem install --no-ri --no-rdoc ffi corefoundation"

cd ${HOME}/src/yakg/vendor/gems/ruby && rm -rf *
mkdir -p 1.8 x86_64/1.9.1 x86_64/2.0.0 x86_64/2.1.0 x86_64/2.2.0 \
  i386/1.9.1 1.8 i386/2.0.0 i386/2.1.0 i386/2.2.0

pushd ${HOME}/.rbenv/versions
for VERS in ${R191} ${R200} ${R210} ${R220}; do
  rm ${VERS}
  ln -sf x86_64-${VERS} ${VERS}
done
popd

echo ${R18} > ${HOME}/.rbenv/version
${GEM_CMD} -i ./1.8

pushd x86_64

echo ${R191} > ${HOME}/.rbenv/version
${GEM_CMD} -i ./1.9.1

echo ${R200} > ${HOME}/.rbenv/version
${GEM_CMD} -i ./2.0.0

popd

pushd ${HOME}/.rbenv/versions
rm ${R191} ${R200}
ln -sf i386-${R191} ${R191}
ln -sf i386-${R200} ${R200}
popd

pushd i386

echo ${R191} > ${HOME}/.rbenv/version
${GEM_CMD} -i ./1.9.1

echo ${R200} > ${HOME}/.rbenv/version
${GEM_CMD} -i ./2.0.0

popd

mv x86_64/{2.0.0,1.9.1} .

lipo i386/1.9.1/gems/ffi-*/lib/ffi_c.bundle 1.9.1/gems/ffi-*/lib/ffi_c.bundle \
    -create -output 1.9.1/gems/ffi-${FFI_VER}/lib/ffi_c_universal.bundle
lipo i386/2.0.0/gems/ffi-*/lib/ffi_c.bundle 2.0.0/gems/ffi-*/lib/ffi_c.bundle \
    -create -output 2.0.0/gems/ffi-${FFI_VER}/lib/ffi_c_universal.bundle

rm {2.0.0,1.9.1}/gems/ffi-*/lib/ffi_c.bundle

pushd 2.0.0/gems/ffi-*/lib
mv ffi_c_universal.bundle ffi_c.bundle
popd
pushd 1.9.1/gems/ffi-*/lib
mv ffi_c_universal.bundle ffi_c.bundle
popd

rm -rf i386 x86_64 */{cache,doc} */gems/*/{spec,ext,libtest}
