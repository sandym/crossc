cmake_minimum_required(VERSION 3.20)
project(crossc)

# support:
#	centos7-gcc8
#	centos7-gcc11
#	centos9-gcc
#	ubuntu_lts-gcc
#	ubuntu-gcc

set(CROSSC_TARGET centos7-gcc8 CACHE STRING "target")

# some constants, DESTROOT, SYSROOT, TARGET_MAKEFILE, TARGET_FILES
set(DESTROOT /opt/cross/${CROSSC_TARGET})
set(SYSROOT ${DESTROOT}/sysroot)
set(TARGET_MAKEFILE ${CMAKE_SOURCE_DIR}/scripts/${CROSSC_TARGET}.makefile)
set(TARGET_FILES ${CMAKE_SOURCE_DIR}/scripts/${CROSSC_TARGET}_FILES)

# validate that we have the makefile
if(NOT EXISTS ${TARGET_MAKEFILE})
	message(FATAL_ERROR "unsupported CROSSC_TARGET = ${CROSSC_TARGET}")
endif()

# gmp, mpfr and mpc hardcoded to latest version
set(GMP_VERSION 6.2.1)
set(MPFR_VERSION 4.1.0)
set(MPC_VERSION 1.2.1)

# some gcc might need a specific version of isl
execute_process(
	COMMAND make -f ${TARGET_MAKEFILE} ISL_VERSION
	WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/scripts
	OUTPUT_VARIABLE ISL_VERSION
)
string(STRIP ${ISL_VERSION} ISL_VERSION)

include(ExternalProject)
include(ProcessorCount)
ProcessorCount(NPROC)
if(NPROC EQUAL 0)
  set(NPROC 1)
endif()

###
# gmp
###
ExternalProject_Add(gmp
	URL https://ftp.gnu.org/gnu/gmp/gmp-${GMP_VERSION}.tar.xz

	BUILD_IN_SOURCE Yes
	
	CONFIGURE_COMMAND ./configure --prefix=<INSTALL_DIR>
	BUILD_COMMAND make -j${NPROC}
	INSTALL_COMMAND make install

	INSTALL_DIR ${DESTROOT}
)

###
# mpfr
###
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

###
# isl
###
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

###
# mpc
###
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

###
# binutils
###
execute_process(
	COMMAND make -f ${TARGET_MAKEFILE} BINUTILS_PKG
	OUTPUT_VARIABLE BINUTILS_PKG
)

ExternalProject_Add(binutils
	URL ${BINUTILS_PKG}

	BUILD_IN_SOURCE Yes
	
	PATCH_COMMAND make -f ${TARGET_MAKEFILE} BINUTILS_PATCH INSTALL_DIR=<INSTALL_DIR> SYSROOT=${SYSROOT} FILES=${TARGET_FILES}
	CONFIGURE_COMMAND make -f ${TARGET_MAKEFILE} BINUTILS_CONFIGURE INSTALL_DIR=<INSTALL_DIR> SYSROOT=${SYSROOT} FILES=${TARGET_FILES}
	BUILD_COMMAND make -f ${TARGET_MAKEFILE} BINUTILS_BUILD INSTALL_DIR=<INSTALL_DIR> SYSROOT=${SYSROOT} FILES=${TARGET_FILES}
	INSTALL_COMMAND make -f ${TARGET_MAKEFILE} BINUTILS_INSTALL INSTALL_DIR=<INSTALL_DIR> SYSROOT=${SYSROOT} FILES=${TARGET_FILES}

	INSTALL_DIR ${DESTROOT}
)

###
# compiler
###
execute_process(
	COMMAND make -f ${TARGET_MAKEFILE} COMPILER_PKG
	OUTPUT_VARIABLE COMPILER_PKG
)

ExternalProject_Add(compiler
	URL ${COMPILER_PKG}

	BUILD_IN_SOURCE Yes
	
	PATCH_COMMAND make -f ${TARGET_MAKEFILE} COMPILER_PATCH INSTALL_DIR=<INSTALL_DIR> SYSROOT=${SYSROOT} FILES=${TARGET_FILES}
	CONFIGURE_COMMAND make -f ${TARGET_MAKEFILE} COMPILER_CONFIGURE INSTALL_DIR=<INSTALL_DIR> SYSROOT=${SYSROOT} FILES=${TARGET_FILES}
	BUILD_COMMAND make -f ${TARGET_MAKEFILE} COMPILER_BUILD INSTALL_DIR=<INSTALL_DIR> SYSROOT=${SYSROOT} FILES=${TARGET_FILES}
	INSTALL_COMMAND make -f ${TARGET_MAKEFILE} COMPILER_INSTALL INSTALL_DIR=<INSTALL_DIR> SYSROOT=${SYSROOT} FILES=${TARGET_FILES}

	INSTALL_DIR ${DESTROOT}
)
add_dependencies(compiler binutils mpc mpfr isl gmp)

###
# sysroot pre-compiled packages
###
execute_process(
	COMMAND make -f ${TARGET_MAKEFILE} SYSROOT_PKGS
	WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/scripts
	OUTPUT_VARIABLE SYSROOT_PKGS
)
string(REPLACE "\n" ";" SYSROOT_PKGS ${SYSROOT_PKGS})

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
