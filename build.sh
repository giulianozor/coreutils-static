#!/bin/sh

coreutils_version="8.31"

curl -LO http://ftp.gnu.org/gnu/coreutils/coreutils-${coreutils_version}.tar.xz
tar xJf coreutils-${coreutils_version}.tar.xz

cd coreutils-${coreutils_version}
env FORCE_UNSAFE_CONFIGURE=1 CFLAGS="-static -Os -ffunction-sections -fdata-sections" LDFLAGS='-Wl,--gc-sections' ./configure
make
cd ..

mkdir /release

find coreutils-${coreutils_version}/src/ -executable -type f -exec strip -s -R .comment -R .gnu.version --strip-unneeded {} \; 
find coreutils-${coreutils_version}/src/ -executable -type f -exec upx --ultra-brute {} \; 
find coreutils-${coreutils_version}/src/ -executable -type f -exec cp {} /release \;
