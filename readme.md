
# crossc

### Building cross toolchain for linux distros.

The goal is to be able to build a `x86-64` linux projects from an Apple Silicon
chip.

Running the compiler from an `x86-64` docker image result in a build time 2 to 3
times slower (!) because each invocation of `gcc` runs through `rosetta` while
building with a native compiler is much *faster* (in my limited tests, building
clang+tooling: `arm64`: *20 minutes*, `x86-64`: *45 minutes*).

This repo contains scripts to build cross toolchains for some specific linux
distros.

### Requirement

- `cmake`
- `sudo port install autoconf autoconf-archive automake gmake gsed m4`

## Status

### centos9 gcc-toolset-13


@todo:
- a fast linker ?
- cmake cross toolchain
- build steps dependencies to fix: the source code is re-copied every time cmake files change.

## How to build

Make sure that `/opt/cross` exists and is writable.

```
> mkdir crossc/build
> cd crossc/build
> cmake -G Ninja -DCROSSC_PLATFORM=centos9-gcc13 ../.
> ninja
```

It will build and install the cross toolchain in `/opt/cross/centos9-gcc13-x86_64`.

`/opt/cross/centos9-gcc13-x86_64/bin`:
- ...

