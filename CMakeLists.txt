cmake_minimum_required(VERSION 3.24)
project(crossc)

find_program(MAKE gmake)

# support:
#	centos9-gcc13

set(CROSSC_PLATFORM centos9-gcc13 CACHE STRING "platform")
set(CROSSC_TARGET x86_64 CACHE STRING "target")

# some constants, DESTROOT, SYSROOT, TARGET_MAKEFILE
set(DESTROOT /opt/cross/${CROSSC_PLATFORM}-${CROSSC_TARGET})
set(SYSROOT ${DESTROOT}/sysroot)

include(scripts/${CROSSC_PLATFORM}/CMakeLists.txt)

message(STATUS "using isl version ${ISL_VERSION}")
message(STATUS "using sysroot packages:")
foreach(PKG ${SYSROOT_PKGS})
	message("    ${PKG}")
endforeach()

# gmp, mpfr and mpc hardcoded to latest version
set(GMP_VERSION 6.2.1)
set(MPFR_VERSION 4.1.0)
set(MPC_VERSION 1.2.1)

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
	PREFIX gmp

	BUILD_IN_SOURCE Yes
	
	CONFIGURE_COMMAND ./configure --prefix=<INSTALL_DIR>
	BUILD_COMMAND ${MAKE} -j${NPROC}
	INSTALL_COMMAND ${MAKE} install

	INSTALL_DIR ${DESTROOT}
)

###
# mpfr
###
ExternalProject_Add(mpfr
	URL https://ftp.gnu.org/gnu/mpfr/mpfr-${MPFR_VERSION}.tar.xz
	PREFIX mpfr

	BUILD_IN_SOURCE Yes
	
	CONFIGURE_COMMAND ./configure --with-gmp=<INSTALL_DIR>
									--prefix=<INSTALL_DIR>
	BUILD_COMMAND ${MAKE}
	INSTALL_COMMAND ${MAKE} install

	INSTALL_DIR ${DESTROOT}
)
add_dependencies(mpfr gmp)

###
# isl
###
ExternalProject_Add(isl
	URL https://gcc.gnu.org/pub/gcc/infrastructure/isl-${ISL_VERSION}.tar.bz2
	PREFIX isl

	BUILD_IN_SOURCE Yes
	
	CONFIGURE_COMMAND autoreconf
	COMMAND ./configure --with-gmp-prefix=<INSTALL_DIR>
									--prefix=<INSTALL_DIR>
	BUILD_COMMAND ${MAKE} -j${NPROC}
	INSTALL_COMMAND ${MAKE} install

	INSTALL_DIR ${DESTROOT}
)
add_dependencies(isl gmp)

###
# mpc
###
ExternalProject_Add(mpc
	URL https://ftp.gnu.org/gnu/mpc/mpc-${MPC_VERSION}.tar.gz
	PREFIX mpc

	BUILD_IN_SOURCE Yes
	
	CONFIGURE_COMMAND ./configure --with-mpfr=<INSTALL_DIR> 
									--with-gmp=<INSTALL_DIR>
									--prefix=<INSTALL_DIR>
	BUILD_COMMAND ${MAKE} -j${NPROC}
	INSTALL_COMMAND ${MAKE} install

	INSTALL_DIR ${DESTROOT}
)
add_dependencies(mpc gmp mpfr)

###
# binutils
###

# - docker srpm patch and copy the source out
# - configure
# - build
# - install

# execute_process(
# 	COMMAND ${MAKE} -f ${TARGET_MAKEFILE} BINUTILS_PKG TARGET=${CROSSC_TARGET}
# 	WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/scripts
# 	OUTPUT_VARIABLE BINUTILS_PKG
# )
# string(STRIP ${BINUTILS_PKG} BINUTILS_PKG)

# ExternalProject_Add(binutils
# 	URL ${BINUTILS_PKG}
# 	BUILD_IN_SOURCE Yes

#  	# PATCH_COMMAND ${MAKE} -f ${TARGET_MAKEFILE} BINUTILS_PATCH CMAKE_SOURCE_DIR=${CMAKE_SOURCE_DIR}
#  	# CONFIGURE_COMMAND ${MAKE} -f ${TARGET_MAKEFILE} BINUTILS_CONFIGURE DESTROOT=${DESTROOT} SYSROOT=${SYSROOT}
#  	# BUILD_COMMAND ${MAKE} -f ${TARGET_MAKEFILE} BINUTILS_BUILD DESTROOT=${DESTROOT} SYSROOT=${SYSROOT}
#  	# INSTALL_COMMAND ${MAKE} -f ${TARGET_MAKEFILE} BINUTILS_INSTALL DESTROOT=${DESTROOT} SYSROOT=${SYSROOT}

#  	INSTALL_DIR ${DESTROOT}
# )


###
# compiler
###
# ExternalProject_Add(compiler
# 	DOWNLOAD_COMMAND touch dummy.txt
# 	BUILD_IN_SOURCE Yes

#  	PATCH_COMMAND ${MAKE} -f ${TARGET_MAKEFILE} COMPILER_PATCH CMAKE_SOURCE_DIR=${CMAKE_SOURCE_DIR}
#  	CONFIGURE_COMMAND ${MAKE} -f ${TARGET_MAKEFILE} COMPILER_CONFIGURE DESTROOT=${DESTROOT} SYSROOT=${SYSROOT}
#  	BUILD_COMMAND ${MAKE} -f ${TARGET_MAKEFILE} COMPILER_BUILD DESTROOT=${DESTROOT} SYSROOT=${SYSROOT}
#  	INSTALL_COMMAND ${MAKE} -f ${TARGET_MAKEFILE} COMPILER_INSTALL DESTROOT=${DESTROOT} SYSROOT=${SYSROOT}

#  	INSTALL_DIR ${DESTROOT}
# )
# add_dependencies(compiler binutils mpc mpfr isl gmp)

###
# sysroot pre-compiled packages
###

set(INDEX 0)
foreach(PKG ${SYSROOT_PKGS})
	ExternalProject_Add(sysroot-${INDEX}
		URL ${PKG}
		PREFIX sysroot-${INDEX}

		DOWNLOAD_NO_EXTRACT Yes
		
		CONFIGURE_COMMAND ""
		BUILD_COMMAND mkdir -p <INSTALL_DIR>
		INSTALL_COMMAND cd <INSTALL_DIR>
		COMMAND cmake -E tar zxf <DOWNLOADED_FILE>

		INSTALL_DIR ${SYSROOT}
	)
	# add_dependencies(compiler sysroot-${INDEX})
	MATH(EXPR INDEX "${INDEX}+1")
endforeach()
