
TARGET = x86_64

ifeq ($(TARGET), x86_64)
	GCC_CONFIG = --enable-targets=x86_64-pep
else
	ALT_ARCH = -altarch
endif

ISL_VERSION:
	@echo 0.16.1

SYSROOT_PKGS:
	@echo http://mirror.centos.org/centos${ALT_ARCH}/7/updates/${TARGET}/Packages/glibc-2.17-325.el7_9.${TARGET}.rpm
	@echo http://mirror.centos.org/centos${ALT_ARCH}/7/updates/${TARGET}/Packages/glibc-devel-2.17-325.el7_9.${TARGET}.rpm
	@echo http://mirror.centos.org/centos${ALT_ARCH}/7/updates/${TARGET}/Packages/glibc-common-2.17-325.el7_9.${TARGET}.rpm
	@echo http://mirror.centos.org/centos${ALT_ARCH}/7/updates/${TARGET}/Packages/glibc-headers-2.17-325.el7_9.${TARGET}.rpm
	@echo http://mirror.centos.org/centos${ALT_ARCH}/7/updates/${TARGET}/Packages/kernel-headers-3.10.0-1160.49.1.el7.${TARGET}.rpm

BINUTILS_PKG:
	@echo https://cbs.centos.org/kojifiles/packages/devtoolset-8-binutils/2.30/55.el7.2/src/devtoolset-8-binutils-2.30-55.el7.2.src.rpm

BINUTILS_PATCH:
	cmake -E tar zxf binutils-2.30.tar.xz
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-2.20.51.0.2-libtool-lib64.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-2.25-version.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-2.22.52.0.1-export-demangle.h.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-2.22.52.0.4-no-config-h-check.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-2.26-lto.patch || exit 0
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-2.29-filename-in-error-messages.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-2.29-revert-PLT-elision.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-readelf-other-sym-info.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-2.27-aarch64-ifunc.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-revert-PowerPC-speculation-barriers.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-skip-dwo-search-if-not-needed.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-page-to-segment-assignment.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-2.30-allow_R_AARCH64-symbols.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-strip-unknown-relocs.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-speed-up-objdump.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-2.28-ignore-gold-duplicates.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-ifunc-relocs-in-notes.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-debug-section-marking.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-gold-llvm-plugin.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-gas-build-notes.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-CVE-2018-7642.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-CVE-2018-7643.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-CVE-2018-7208.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-CVE-2018-10372.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-CVE-2018-10373.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-CVE-2018-7570.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-CVE-2018-6323.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-CVE-2018-6759.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-CVE-2018-7569.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-CVE-2018-7568.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-CVE-2018-10534.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-CVE-2018-10535.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-x86-local-relocs.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-linkonce-notes.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-CVE-2018-8945.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-x86-local-version.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-fix-testsuite-failures.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-PowerPC-IEEE-long-double-warnings.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-2.25-set-long-long.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-missing-notes.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-gold-ignore-discarded-note-relocs.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-merge-attribute-sections.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-remove-empty-ISA-properties.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-note-merge-improvements.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-gold-note-segment.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-disable-readelf-gap-reports.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-do-not-link-with-static-libstdc++.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-attach-to-group.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-CVE-2018-17358.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-nested-func-name-lookup.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-s390x-arch13.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-fix-testsuite-failures-2.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-plugins-need-dlsym.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-x86-JCC-Errata.patch
	cd binutils-2.30 && patch -p1 --fuzz=0 < ../binutils-keep-weak-aliases.patch

BINUTILS_CONFIGURE:
	cd binutils-2.30 && \
	./configure --target=${TARGET}-redhat-linux \
				--prefix=${INSTALL_DIR} \
				--disable-nls \
				--disable-error \
				--enable-ld \
				--enable-gold=default \
				--disable-dependency-tracking \
				--quiet \
				--enable-shared \
				--enable-deterministic-archives=no \
				--enable-lto \
				--enable-compressed-debug-sections=none \
				--enable-generate-build-notes=no \
				${GCC_CONFIG} \
				--enable-relro=yes \
				--enable-plugins \
				--with-sysroot=${SYSROOT}

BINUTILS_BUILD:
	cd binutils-2.30 && \
	make -j$(sysctl -n hw.logicalcpu || nproc)

BINUTILS_INSTALL:
	cd binutils-2.30 && \
	make install

COMPILER_PKG:
	@echo https://cbs.centos.org/kojifiles/packages/devtoolset-8-gcc/8.3.1/3.2.el7/src/devtoolset-8-gcc-8.3.1-3.2.el7.src.rpm

COMPILER_PATCH:
	cmake -E tar zxf gcc-8.3.1-20190311.tar.xz
	cd gcc-8.3.1-20190311 && mkdir b
	cd gcc-8.3.1-20190311 && patch -p0 -b --suffix .hack~ --fuzz=0 < ../gcc8-hack.patch
	cd gcc-8.3.1-20190311 && patch -p0 -b --suffix .i386-libgomp~ --fuzz=0 < ../gcc8-i386-libgomp.patch
	cd gcc-8.3.1-20190311 && patch -p0 -b --suffix .sparc-config-detection~ --fuzz=0 < ../gcc8-sparc-config-detection.patch
	cd gcc-8.3.1-20190311 && patch -p0 -b --suffix .libgomp-omp_h-multilib~ --fuzz=0 < ../gcc8-libgomp-omp_h-multilib.patch
	cd gcc-8.3.1-20190311 && patch -p0 -b --suffix .libtool-no-rpath~ --fuzz=0 < ../gcc8-libtool-no-rpath.patch
	cd gcc-8.3.1-20190311 && patch -p0 -b --suffix .isl-dl~ --fuzz=0 < ../gcc8-isl-dl.patch
	cd gcc-8.3.1-20190311 && patch -p0 -b --suffix .libstdc++-docs~ --fuzz=0 < ../gcc8-libstdc++-docs.patch
	cd gcc-8.3.1-20190311 && patch -p0 -b --suffix .no-add-needed~ --fuzz=0 < ../gcc8-no-add-needed.patch
	cd gcc-8.3.1-20190311 && patch -p0 -b --suffix .foffload-default~ --fuzz=0 < ../gcc8-foffload-default.patch
	cd gcc-8.3.1-20190311 && patch -p0 -b --suffix .Wno-format-security~ --fuzz=0 < ../gcc8-Wno-format-security.patch
	cd gcc-8.3.1-20190311 && patch -p0 -b --suffix .rh1512529-aarch64~ --fuzz=0 < ../gcc8-rh1512529-aarch64.patch
	cd gcc-8.3.1-20190311 && patch -p0 -b --suffix .mcet~ --fuzz=0 < ../gcc8-mcet.patch
	cd gcc-8.3.1-20190311 && patch -p0 -b --suffix .pr85400~ --fuzz=0 < ../gcc8-pr85400.patch
	cd gcc-8.3.1-20190311 && patch -p0 -b --suffix .pr89629~ --fuzz=0 < ../gcc8-pr89629.patch
	cd gcc-8.3.1-20190311 && patch -p0 -b --suffix .pr90139~ --fuzz=0 < ../gcc8-pr90139.patch
	cd gcc-8.3.1-20190311 && patch -p0 -b --suffix .pr90756~ --fuzz=0 < ../gcc8-pr90756.patch
	cd gcc-8.3.1-20190311 && patch -p0 -b --suffix .pr86098~ --fuzz=0 < ../gcc8-pr86098.patch
	cd gcc-8.3.1-20190311 && patch -p0 -b --suffix .rh1760208-1~ --fuzz=0 < ../gcc8-rh1760208-1.patch
	cd gcc-8.3.1-20190311 && patch -p0 -b --suffix .rh1760208-2~ --fuzz=0 < ../gcc8-rh1760208-2.patch
	cd gcc-8.3.1-20190311 && patch -p0 -b --suffix .rh1760208-3~ --fuzz=0 < ../gcc8-rh1760208-3.patch
	cd gcc-8.3.1-20190311 && patch -p0 -b --suffix .rh1760208-4~ --fuzz=0 < ../gcc8-rh1760208-4.patch
	cd gcc-8.3.1-20190311 && patch -p0 -b --suffix .libstdc++-compat~ --fuzz=0 < ../gcc8-libstdc++-compat.patch
	cd gcc-8.3.1-20190311 && patch -p0 -b --suffix .isl-dl2~ --fuzz=0 < ../gcc8-isl-dl2.patch
	cd gcc-8.3.1-20190311 && patch -p1 -b --suffix .fortran03~ --fuzz=0 < ../0003-Add-std-extra-legacy.patch
	cd gcc-8.3.1-20190311 && patch -p1 -b --suffix .fortran01~ --fuzz=0 < ../0001-Allow-repeated-compatible-type-specifications.patch
	cd gcc-8.3.1-20190311 && patch -p1 -b --suffix .fortran02~ --fuzz=0 < ../0002-Pad-character-to-int-conversions-with-spaces-instead.patch
	cd gcc-8.3.1-20190311 && patch -p1 -b --suffix .fortran04~ --fuzz=0 < ../0004-Allow-conversion-between-Hollerith-constants-and-CHA.patch
	cd gcc-8.3.1-20190311 && patch -p1 -b --suffix .fortran05~ --fuzz=0 < ../0005-Allow-comparisons-between-INTEGER-and-REAL.patch
	cd gcc-8.3.1-20190311 && patch -p1 -b --suffix .fortran06~ --fuzz=0 < ../0006-Allow-blank-format-items-in-format-strings.patch
	cd gcc-8.3.1-20190311 && patch -p1 -b --suffix .fortran07~ --fuzz=0 < ../0007-Allow-more-than-one-character-as-argument-to-ICHAR.patch
	cd gcc-8.3.1-20190311 && patch -p1 -b --suffix .fortran08~ --fuzz=0 < ../0008-Allow-non-integer-substring-indexes.patch
	cd gcc-8.3.1-20190311 && patch -p1 -b --suffix .fortran09~ --fuzz=0 < ../0009-Convert-LOGICAL-to-INTEGER-for-arithmetic-ops-and-vi.patch
	cd gcc-8.3.1-20190311 && patch -p1 -b --suffix .fortran10~ --fuzz=0 < ../0010-Allow-mixed-string-length-and-array-specification-in.patch
	cd gcc-8.3.1-20190311 && patch -p1 -b --suffix .fortran11~ --fuzz=0 < ../0011-Allow-character-to-int-conversions-in-DATA-statement.patch
	cd gcc-8.3.1-20190311 && patch -p1 -b --suffix .fortran12~ --fuzz=0 < ../0012-Allow-old-style-initializers-in-derived-types.patch
	cd gcc-8.3.1-20190311 && patch -p1 -b --suffix .fortran13~ --fuzz=0 < ../0013-Allow-per-variable-kind-specification.patch
	cd gcc-8.3.1-20190311 && patch -p1 -b --suffix .fortran14~ --fuzz=0 < ../0014-Allow-non-logical-expressions-in-IF-statements.patch
	cd gcc-8.3.1-20190311 && patch -p1 -b --suffix .fortran16~ --fuzz=0 < ../0016-Allow-calls-to-intrinsics-with-smaller-types-than-sp.patch
	cd gcc-8.3.1-20190311 && patch -p1 -b --suffix .fortran17~ --fuzz=0 < ../0017-Add-the-SEQUENCE-attribute-by-default-if-it-s-not-pr.patch
	cd gcc-8.3.1-20190311 && patch -p1 -b --suffix .fortran18~ --fuzz=0 < ../0018-Fill-in-missing-array-dimensions-using-the-lower-bou.patch
	cd gcc-8.3.1-20190311 && patch -p1 -b --suffix .fortran19~ --fuzz=0 < ../0019-Add-tests-for-AUTOMATIC-keyword.patch
	cd gcc-8.3.1-20190311 && patch -p1 -b --suffix .fortran22~ --fuzz=0 < ../0022-Default-values-for-certain-field-descriptors-in-form.patch
	cd gcc-8.3.1-20190311 && patch -p1 -b --suffix .fortran23~ --fuzz=0 < ../gcc8-fortranlines.patch
	cd gcc-8.3.1-20190311 && patch -p1 -b --suffix .fortran25~ --fuzz=0 < ../gcc8-fortran-equivalence.patch
	cd gcc-8.3.1-20190311 && patch -p1 -b --suffix .fortran26~ --fuzz=0 < ../gcc8-fortran-fdec-include.patch
	cd gcc-8.3.1-20190311 && patch -p1 -b --suffix .fortran27~ --fuzz=0 < ../gcc8-fortran-fdec-include-doc.patch
	cd gcc-8.3.1-20190311 && patch -p1 -b --suffix .fortran28~ --fuzz=0 < ../gcc8-fortran-fpad-source.patch
	cd gcc-8.3.1-20190311 && patch -p1 -b --suffix .fortran29~ --fuzz=0 < ../gcc8-fortran-pr87919.patch
	cd gcc-8.3.1-20190311 && patch -p1 -b --suffix .fortran30~ --fuzz=0 < ../gcc8-fortran-pr87919-2.patch
	cd gcc-8.3.1-20190311 && patch -p0 < "${FILES}/clang_fix.patch"
	cd gcc-8.3.1-20190311 && patch -p1 < "${FILES}/disable_pch.patch"

COMPILER_CONFIGURE:
	cd gcc-8.3.1-20190311/b && \
	../configure --target=${TARGET}-redhat-linux \
			--prefix=${INSTALL_DIR} \
			--enable-shared \
			--enable-threads=posix \
			--enable-checking=release \
			--enable-__cxa_atexit \
			--disable-libunwind-exceptions \
			--enable-gnu-unique-object \
			--enable-linker-build-id \
			--with-gcc-major-version-only \
			--with-linker-hash-style=gnu \
			--with-default-libstdcxx-abi=gcc4-compatible \
			--enable-plugin \
			--enable-initfini-array \
			--disable-libmpx \
			--enable-gnu-indirect-function \
			--with-tune=generic \
			--disable-multilib \
			--with-system-zlib \
			--with-mpc=${INSTALL_DIR} \
			--with-mpfr=${INSTALL_DIR} \
			--with-gmp=${INSTALL_DIR} \
			--with-isl=${INSTALL_DIR} \
			--enable-languages=c,c++,lto \
			--with-sysroot=${SYSROOT}

# --enable-multilib instead of --disable-multilib ?
# --enable-bootstrap

COMPILER_BUILD:
	cd gcc-8.3.1-20190311/b && \
	make -j$(sysctl -n hw.logicalcpu || nproc)

COMPILER_INSTALL:
	cd gcc-8.3.1-20190311/b && \
	make install
