
SYSROOT_PKGS:
	@echo http://mirror.centos.org/centos/7/updates/x86_64/Packages/glibc-2.17-325.el7_9.x86_64.rpm
	@echo http://mirror.centos.org/centos/7/updates/x86_64/Packages/glibc-devel-2.17-325.el7_9.x86_64.rpm
	@echo http://mirror.centos.org/centos/7/updates/x86_64/Packages/glibc-common-2.17-325.el7_9.x86_64.rpm
	@echo http://mirror.centos.org/centos/7/updates/x86_64/Packages/glibc-headers-2.17-325.el7_9.x86_64.rpm
	@echo http://mirror.centos.org/centos/7/updates/x86_64/Packages/kernel-headers-3.10.0-1160.49.1.el7.x86_64.rpm

BINUTILS_PKG:
	@echo https://ftp.gnu.org/gnu/binutils/binutils-2.37.tar.xz

BINUTILS_PATCH:

BINUTILS_CONFIGURE:
	./configure --target=x86_64-redhat-linux \
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
	@echo https://cbs.centos.org/kojifiles/packages/devtoolset-10-gcc/10.2.1/11.2.el7/src/devtoolset-10-gcc-10.2.1-11.2.el7.src.rpm

COMPILER_PATCH:
	cmake -E tar -zxf gcc-10.2.1-20210130.tar.xz
	cd gcc-10.2.1-20210130 && patch -p1 < "${FILES}/disable_pch.patch"
	cd gcc-10.2.1-20210130 && mkdir b

COMPILER_CONFIGURE:
	cd gcc-10.2.1-20210130/b && \
	../configure --target=x86_64-redhat-linux \
			--prefix=${INSTALL_DIR} \
			--disable-multilib \
			--with-mpc=${INSTALL_DIR} \
			--with-mpfr=${INSTALL_DIR} \
			--with-gmp=${INSTALL_DIR} \
			--with-isl=${INSTALL_DIR} \
			--enable-languages=c,c++,lto \
			--with-sysroot=${SYSROOT}

COMPILER_BUILD:
	cd gcc-10.2.1-20210130/b && \
	make -j$(sysctl -n hw.logicalcpu || nproc)

COMPILER_INSTALL:
	cd gcc-10.2.1-20210130/b && \
	make install
