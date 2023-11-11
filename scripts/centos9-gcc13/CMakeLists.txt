
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
	if (${line} MATCHES "${CROSSC_TARGET}")
		list(APPEND SYSROOT_PKGS ${line})
	endif()
endforeach()
