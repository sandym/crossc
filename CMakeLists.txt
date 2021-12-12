cmake_minimum_required(VERSION 3.20)
project(crossc)

# support:
#	centos7-gcc8
#	centos7-gcc10
#	centos9-gcc
#	ubuntu_lts-gcc
#	ubuntu-gcc

set(CROSSC_TARGET centos7-gcc10 CACHE STRING "target")

set(DESTROOT /opt/cross/${CROSSC_TARGET})
set(SYSROOT ${DESTROOT}/sysroot)

if(${CROSSC_TARGET} STREQUAL "centos7-gcc10")
	set(SYSROOT_PKGS
		http://mirror.centos.org/centos/7/updates/x86_64/Packages/glibc-2.17-325.el7_9.x86_64.rpm
		http://mirror.centos.org/centos/7/updates/x86_64/Packages/glibc-devel-2.17-325.el7_9.x86_64.rpm
		http://mirror.centos.org/centos/7/updates/x86_64/Packages/glibc-common-2.17-325.el7_9.x86_64.rpm
		http://mirror.centos.org/centos/7/updates/x86_64/Packages/glibc-headers-2.17-325.el7_9.x86_64.rpm
		http://mirror.centos.org/centos/7/updates/x86_64/Packages/kernel-headers-3.10.0-1160.49.1.el7.x86_64.rpm
	)
else()
	message(FATAL_ERROR "unsupported CROSSC_TARGET = ${CROSSC_TARGET}")
endif()

set(GMP_VERSION 6.2.1)
set(MPFR_VERSION 4.1.0)
set(ISL_VERSION 0.24)
set(MPC_VERSION 1.2.1)
set(BINUTILS_VERSION 2.37)


include(ExternalProject)
include(ProcessorCount)
ProcessorCount(NPROC)
if(NPROC EQUAL 0)
  set(NPROC 1)
endif()

ExternalProject_Add(gmp
	URL https://ftp.gnu.org/gnu/gmp/gmp-${GMP_VERSION}.tar.xz

	BUILD_IN_SOURCE Yes
	
	CONFIGURE_COMMAND ./configure --prefix=<INSTALL_DIR>
	BUILD_COMMAND make -j${NPROC}
	INSTALL_COMMAND make install

	INSTALL_DIR ${DESTROOT}
)

ExternalProject_Add(mpfr
	URL https://ftp.gnu.org/gnu/mpfr/mpfr-${MPFR_VERSION}.tar.xz

	BUILD_IN_SOURCE Yes
	
	CONFIGURE_COMMAND ./configure --with-gmp=<INSTALL_DIR>
									--prefix=<INSTALL_DIR>
	BUILD_COMMAND make -j${NPROC}
	INSTALL_COMMAND make install

	INSTALL_DIR ${DESTROOT}
)
add_dependencies(mpfr gmp)

ExternalProject_Add(isl
	URL https://gcc.gnu.org/pub/gcc/infrastructure/isl-${ISL_VERSION}.tar.bz2

	BUILD_IN_SOURCE Yes
	
	CONFIGURE_COMMAND ./configure --with-gmp-prefix=<INSTALL_DIR>
									--prefix=<INSTALL_DIR>
	BUILD_COMMAND make -j${NPROC}
	INSTALL_COMMAND make install

	INSTALL_DIR ${DESTROOT}
)
add_dependencies(isl gmp)

ExternalProject_Add(mpc
	URL https://ftp.gnu.org/gnu/mpc/mpc-${MPC_VERSION}.tar.gz

	BUILD_IN_SOURCE Yes
	
	CONFIGURE_COMMAND ./configure --with-mpfr=<INSTALL_DIR> 
									--with-gmp=<INSTALL_DIR>
									--prefix=<INSTALL_DIR>
	BUILD_COMMAND make -j${NPROC}
	INSTALL_COMMAND make install

	INSTALL_DIR ${DESTROOT}
)
add_dependencies(mpc gmp mpfr)

set(ENABLE_GOLD yes)
if(APPLE)
	set(ENABLE_GOLD no)
endif()

ExternalProject_Add(binutils
	URL https://ftp.gnu.org/gnu/binutils/binutils-${BINUTILS_VERSION}.tar.xz

	BUILD_IN_SOURCE Yes
	
	CONFIGURE_COMMAND ./configure --target=x86_64-redhat-linux
									--prefix=<INSTALL_DIR>
									--disable-nls
									--disable-error
									--enable-ld=yes
									--enable-gold=${ENABLE_GOLD}
									--with-sysroot=${SYSROOT}
	BUILD_COMMAND make -j${NPROC}
	INSTALL_COMMAND make install

	INSTALL_DIR ${DESTROOT}
)

ExternalProject_Add(compiler
	URL https://cbs.centos.org/kojifiles/packages/devtoolset-10-gcc/10.2.1/11.2.el7/src/devtoolset-10-gcc-10.2.1-11.2.el7.src.rpm

	BUILD_IN_SOURCE Yes
	
	CONFIGURE_COMMAND ""
	BUILD_COMMAND ${CMAKE_SOURCE_DIR}/scripts/${CROSSC_TARGET}.sh <INSTALL_DIR> ${SYSROOT}
	INSTALL_COMMAND ""

	INSTALL_DIR ${DESTROOT}
)
add_dependencies(compiler binutils mpc mpfr isl gmp)

set(INDEX 0)
foreach(PKG ${SYSROOT_PKGS})
	ExternalProject_Add(sysroot-${INDEX}
		URL ${PKG}

		DOWNLOAD_NO_EXTRACT Yes
		
		CONFIGURE_COMMAND ""
		BUILD_COMMAND mkdir -p <INSTALL_DIR>
		INSTALL_COMMAND cd <INSTALL_DIR>
		COMMAND cmake -E tar zxf <DOWNLOADED_FILE>

		INSTALL_DIR ${SYSROOT}
	)
	add_dependencies(compiler sysroot-${INDEX})
	MATH(EXPR INDEX "${INDEX}+1")
endforeach()
