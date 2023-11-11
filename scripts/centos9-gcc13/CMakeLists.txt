
message(STATUS "building helper docker image")
execute_process(
	COMMAND docker build --platform linux/${CROSSC_TARGET} -t centos9-gcc13-helper .
	WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}
)
message(STATUS "building helper docker image - done")

# specific isl version
set(ISL_VERSION 0.24)

message(STATUS "gathering sysroot packages")
execute_process(
	COMMAND docker run --rm --platform linux/${CROSSC_TARGET}
			centos9-gcc13-helper
			yumdownloader --url glibc glibc-devel glibc-common glibc-headers kernel-headers
	WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}
	OUTPUT_VARIABLE SYSROOT_PKGS_OUTPUT
)
string(REPLACE "\n" ";" SYSROOT_PKGS_OUTPUT "${SYSROOT_PKGS_OUTPUT}")
message(STATUS "gathering sysroot packages - done")

set(SYSROOT_PKGS "")
foreach(line ${SYSROOT_PKGS_OUTPUT})
	if (${line} MATCHES "${CROSSC_TARGET}.rpm")
		list(APPEND SYSROOT_PKGS ${line})
	endif()
endforeach()

file(REMOVE
	${CMAKE_BINARY_DIR}/binutils_src
	${CMAKE_BINARY_DIR}/gcc_src
)
execute_process(
	COMMAND docker create --platform linux/${CROSSC_TARGET}
			--name=centos9-gcc13-helper centos9-gcc13-helper
	WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}
)
message(STATUS "getting binutils patched source code")
execute_process(
	COMMAND docker cp centos9-gcc13-helper:/root/binutils_src ${CMAKE_BINARY_DIR}/.
	WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}
)
message(STATUS "getting gcc patched source code")
execute_process(
	COMMAND docker cp centos9-gcc13-helper:/root/gcc_src ${CMAKE_BINARY_DIR}/.
	WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}
)
execute_process(
	COMMAND docker rm centos9-gcc13-helper
	WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}
)
