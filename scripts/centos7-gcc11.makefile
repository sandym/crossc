TARGET = x86_64

ISL_VERSION:
	@echo 0.24

SYSROOT_PKGS:
	@echo http://mirror.centos.org/centos/7/updates/${TARGET}/Packages/glibc-2.17-325.el7_9.${TARGET}.rpm
	@echo http://mirror.centos.org/centos/7/updates/${TARGET}/Packages/glibc-devel-2.17-325.el7_9.${TARGET}.rpm
	@echo http://mirror.centos.org/centos/7/updates/${TARGET}/Packages/glibc-common-2.17-325.el7_9.${TARGET}.rpm
	@echo http://mirror.centos.org/centos/7/updates/${TARGET}/Packages/glibc-headers-2.17-325.el7_9.${TARGET}.rpm
	@echo http://mirror.centos.org/centos/7/updates/${TARGET}/Packages/kernel-headers-3.10.0-1160.49.1.el7.${TARGET}.rpm

BINUTILS_PKG:
	@echo https://ftp.gnu.org/gnu/binutils/binutils-2.37.tar.xz

BINUTILS_PATCH:

BINUTILS_CONFIGURE:
	./configure --target=${TARGET}-redhat-linux \
				--prefix=${INSTALL_DIR} \
				--disable-nls \
				--disable-error \
				--enable-ld=yes \
				--enable-gold=no \
				--with-sysroot=${SYSROOT} \

BINUTILS_BUILD:
	make -j$(sysctl -n hw.logicalcpu || nproc)

BINUTILS_INSTALL:
	make install


COMPILER_PKG:
	@echo https://cbs.centos.org/kojifiles/packages/devtoolset-11-gcc/11.2.1/1.2.el7/src/devtoolset-11-gcc-11.2.1-1.2.el7.src.rpm

COMPILER_PATCH:
	cmake -E tar -zxf gcc-11.2.1-20210728.tar.xz
	cd gcc-11.2.1-20210728 && patch -p1 < "${FILES}/disable_pch.patch"
	cd gcc-11.2.1-20210728 && mkdir b

COMPILER_CONFIGURE:
	cd gcc-11.2.1-20210728/b && \
	../configure --target=${TARGET}-redhat-linux \
			--prefix=${INSTALL_DIR} \
			--disable-multilib \
			--with-mpc=${INSTALL_DIR} \
			--with-mpfr=${INSTALL_DIR} \
			--with-gmp=${INSTALL_DIR} \
			--with-isl=${INSTALL_DIR} \
			--enable-languages=c,c++,lto \
			--with-sysroot=${SYSROOT}

COMPILER_BUILD:
	cd gcc-11.2.1-20210728/b && \
	make -j$(sysctl -n hw.logicalcpu || nproc)

COMPILER_INSTALL:
	cd gcc-11.2.1-20210728/b && \
	make install
