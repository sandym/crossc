set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR "x86_64")

set(CMAKE_SYSROOT /opt/cross/centos9-gcc13-x86_64/sysroot)

set(tools /opt/cross/centos9-gcc13-x86_64)
set(CMAKE_C_COMPILER ${tools}/bin/x86_64-redhat-linux-gcc)
set(CMAKE_CXX_COMPILER ${tools}/bin/x86_64-redhat-linux-g++)

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
