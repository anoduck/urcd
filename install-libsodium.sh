#!/bin/sh

echo "
this library breaks compatibility with NaCl's crypto_sign. \
crypto_sign_edwards25519sha512batch implementation segfaults. \
i no longer support libsodium until the developers make a non-sloppy product. \
" 1>&2

exit 255


if which wget 2>/dev/null 1>&2; then
  retr=wget
elif which curl 2>/dev/null 1>&2; then
  retr="curl -O"
elif which ftp 2>/dev/null 1>&2; then
  retr="ftp"
else
  echo "could not find any appropiate way to download sources, no wget, curl or ftp in PATH";
  exit 1;
fi

rm -rf libsodium-0.6.0
[ -f libsodium-0.6.0.tar.gz ] || $retr http://download.libsodium.org/libsodium/releases/libsodium-0.6.0.tar.gz
tar xzf libsodium-0.6.0.tar.gz

cd libsodium-0.6.0

./configure && make && make install
