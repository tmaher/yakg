#!/bin/bash

# totally cribbed from https://gist.github.com/tmiz/1441111

OPENSSL_VERSION="1.0.1e"

curl -O http://www.openssl.org/source/openssl-$OPENSSL_VERSION.tar.gz
tar -xvzf openssl-$OPENSSL_VERSION.tar.gz
mv openssl-$OPENSSL_VERSION openssl_i386
tar -xvzf openssl-$OPENSSL_VERSION.tar.gz
mv openssl-$OPENSSL_VERSION openssl_x86_64
cd openssl_i386
./Configure darwin-i386-cc -shared
make
cd ../
cd openssl_x86_64
./Configure darwin64-x86_64-cc -shared
make
cd ../
lipo -create openssl_i386/libcrypto.1.0.0.dylib openssl_x86_64/libcrypto.1.0.0.dylib -output libcrypto.1.0.0.dylib
lipo -create openssl_i386/libssl.1.0.0.dylib openssl_x86_64/libssl.1.0.0.dylib -output libssl.1.0.0.dylib
rm openssl-$OPENSSL_VERSION.tar.gz

chmod u+w /usr/local/opt/openssl/lib/lib*1.0.0.dylib
BACKUP="x86_64-only.`date +%s`"
(cd /usr/local/opt/openssl && mkdir "${BACKUP}" && \
    mv lib*1.0.0.dylib "${BACKUP}") && \
    cp *.dylib /usr/local/opt/openssl
chmod ugo-w /usr/local/opt/openssl/lib/lib*1.0.0.dylib

echo "*****************************************"
echo ""
echo "DONE, these should be universal binaries now"
echo "libssl - `file /usr/local/opt/openssl/lib/libssl.1.0.0.dylib`"
echo "libcrypto - `file /usr/local/opt/openssl/lib/libcrypto.1.0.0.dylib`"
