
# crossc

### Building cross toolchain for (some) linux distros.

The goal is to be able to build a `x86-64` linux projects from an Apple M1 chip.

Running the compiler from an `x86-64` docker image result in a build time 30 times slower (!) because each invocation of `gcc` runs through `qemu` while building with a native compiler is much *faster* (in my limited tests, building clang+tooling: `arm64`: *20 minutes*, `x86-64`: *7 hours*).

This repo contains scripts to build cross toolchains for some specific linux distros.

## Status

### centos7 devtoolset-10

- It builds the centos7 devtoolset-10 `gcc` version and is able to compile and link a native binary!
```
/a.out: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically linked (uses shared libs), for GNU/Linux 2.6.32, not stripped
```

- binary does not run :-( , it's probably because I'm not applying the extensive set of _redhat_ patches, yet.

```
/a.out: /lib64/libstdc++.so.6: version `CXXABI_1.3.9' not found (required by /a.out)
/a.out: /lib64/libstdc++.so.6: version `GLIBCXX_3.4.21' not found (required by /a.out)
```

@todo:
- build the correct version of `binutils` with the _redhat_ patches.
- build `gcc` with the _redhat_ patches.
- `gold` linker is not built (?)

### centos7 devtoolset-8
- `binutils` + _redhat_ patches
- `gcc` + _redhat_ patches
- It builds and generated binaries run in `centos:7` `x86_64` !!!

### centos9 `binutils` and `gcc`
- not started

### ubuntu ?
- not started

## How to build

Make sure that `/opt/cross` exists and is writable.

```
> mkdir crossc/build
> cd crossc/build
> cmake -G Ninja -DCROSSC_TARGET=centos7-gcc10 ../.
> ninja
```

It will build and install the cross toolchain in `/opt/cross/centos7-gcc10`.

`/opt/cross/centos7-gcc10/bin`:
- `x86_64-redhat-linux-addr2line`
- `x86_64-redhat-linux-ar`
- `x86_64-redhat-linux-as`
- `x86_64-redhat-linux-c++`
- `x86_64-redhat-linux-c++filt`
- `x86_64-redhat-linux-cpp`
- `x86_64-redhat-linux-elfedit`
- `x86_64-redhat-linux-g++`
- `x86_64-redhat-linux-gcc`
- `x86_64-redhat-linux-gcc-10.2.1`
- `x86_64-redhat-linux-gcc-ar`
- `x86_64-redhat-linux-gcc-nm`
- `x86_64-redhat-linux-gcc-ranlib`
- `x86_64-redhat-linux-gcov`
- `x86_64-redhat-linux-gcov-dump`
- `x86_64-redhat-linux-gcov-tool`
- `x86_64-redhat-linux-gprof`
- `x86_64-redhat-linux-ld`
- `x86_64-redhat-linux-ld.bfd`
- `x86_64-redhat-linux-lto-dump`
- `x86_64-redhat-linux-nm`
- `x86_64-redhat-linux-objcopy`
- `x86_64-redhat-linux-objdump`
- `x86_64-redhat-linux-ranlib`
- `x86_64-redhat-linux-readelf`
- `x86_64-redhat-linux-size`
- `x86_64-redhat-linux-strings`
- `x86_64-redhat-linux-strip`
