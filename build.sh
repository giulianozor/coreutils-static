#!/bin/bash
#
# build static coreutils because we need exercises in minimalism
# MIT licensed: google it or see robxu9.mit-license.org.
#
# For Linux, also builds musl for truly static linking.

coreutils_version="8.31"
musl_version="1.1.24"

platform=$(uname -s)

# download tarballs
echo "= downloading coreutils"
curl -LO http://ftp.gnu.org/gnu/coreutils/coreutils-${coreutils_version}.tar.xz

echo "= extracting coreutils"
tar xJf coreutils-${coreutils_version}.tar.xz

#echo "= downloading musl"
#curl -LO http://www.musl-libc.org/releases/musl-${musl_version}.tar.gz

#echo "= extracting musl"
#tar -xf musl-${musl_version}.tar.gz

#echo "= building musl"
#working_dir=$(pwd)

#install_dir=${working_dir}/musl-install

#cd musl-${musl_version}
#env CFLAGS="$CFLAGS -Os -ffunction-sections -fdata-sections" LDFLAGS='-Wl,--gc-sections' ./configure --prefix=${install_dir}
#make install
#cd ..

echo "= setting CC to musl-gcc"
#export CC=${working_dir}/musl-install/bin/musl-gcc
export CFLAGS="-static"

echo "= building coreutils"

cd coreutils-${coreutils_version}
env FORCE_UNSAFE_CONFIGURE=1 CFLAGS="$CFLAGS -Os -ffunction-sections -fdata-sections" LDFLAGS='-Wl,--gc-sections' ./configure
make
cd ..

mkdir releases

find coreutils-${coreutils_version}/src/ -executable -type f -exec strip -s -R .comment -R .gnu.version --strip-unneeded {} \; 
find coreutils-${coreutils_version}/src/ -executable -type f -exec upx --ultra-brute {} \; 
find coreutils-${coreutils_version}/src/ -executable -type f -exec cp {} release \;

echo "= done"
