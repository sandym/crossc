
SYSROOT_PKGS:
	@echo http://mirror.centos.org/centos/7/updates/x86_64/Packages/glibc-2.17-325.el7_9.x86_64.rpm
	@echo http://mirror.centos.org/centos/7/updates/x86_64/Packages/glibc-devel-2.17-325.el7_9.x86_64.rpm
	@echo http://mirror.centos.org/centos/7/updates/x86_64/Packages/glibc-common-2.17-325.el7_9.x86_64.rpm
	@echo http://mirror.centos.org/centos/7/updates/x86_64/Packages/glibc-headers-2.17-325.el7_9.x86_64.rpm
	@echo http://mirror.centos.org/centos/7/updates/x86_64/Packages/kernel-headers-3.10.0-1160.49.1.el7.x86_64.rpm

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
	./configure --target=x86_64-redhat-linux \
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
				--enable-targets=x86_64-pep \
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

COMPILER_CONFIGURE:

COMPILER_BUILD:

COMPILER_INSTALL:
