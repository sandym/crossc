
# crossc

### Building cross toolchain for (some) linux distros.

The goal is to be able to build a `x86-64` linux projects from an Apple M1 chips.

Running the compiler from an `x86-64` docker image result in a build time 30 times slower (!) because each invocation of `gcc` runs through `qemu` while building with a native compiler is much *faster* (in my limited tests, building clang+tooling: `arm64`: *20 minutes*, `x86-64`: *7 hours*).

This repo contains scripts to build cross toolchains for some specific linux distros.

## Status

### centos7 devtoolset-10

- It builds the centos7 devtoolset-10 `gcc` version and is able to compile and link a native binary!
```
/a.out: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically linked (uses shared libs), for GNU/Linux 2.6.32, not stripped
```

- binary does not run :-( , it's probably because I'm not applying the extensive set of redhat patches, yet.

```
/a.out: /lib64/libstdc++.so.6: version `CXXABI_1.3.9' not found (required by /a.out)
/a.out: /lib64/libstdc++.so.6: version `GLIBCXX_3.4.21' not found (required by /a.out)
```

@todo:
- build the correct version of `binutils` with the redhat patches.
- build `gcc` with the redhat patches.

### centos7 devtoolset-8
- not started

### centos9 `binutils` and `gcc`
- not started

### ubuntu ?
- not started
