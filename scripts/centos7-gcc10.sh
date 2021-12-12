#!/bin/sh
# archive
# patch
# configure
# build
# install

INSTALL_DIR=$1
SYSROOT=$2
SCRIPTS=$(dirname "$0")
SCRIPTS=$(cd "${SCRIPTS}" ; pwd)

cmake -E tar -zxf gcc-10.2.1-20210130.tar.xz
cd gcc-10.2.1-20210130 || exit 1

# disable pch
patch -p1 < "${SCRIPTS}/centos7-gcc10_files/disable_pch.patch"

mkdir b
cd b
../configure --target=x86_64-redhat-linux \
			--prefix=${INSTALL_DIR} \
			--disable-multilib \
			--with-mpc=${INSTALL_DIR} \
			--with-mpfr=${INSTALL_DIR} \
			--with-gmp=${INSTALL_DIR} \
			--with-isl=${INSTALL_DIR} \
			--enable-languages=c,c++,lto \
			--with-sysroot=${SYSROOT}
			
make -j$(sysctl -n hw.logicalcpu || nproc)
make install
