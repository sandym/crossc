# syntax=docker/dockerfile:1
FROM quay.io/centos/centos:stream9

RUN <<EOT
set -e
dnf -y install \
	bsdtar \
	gcc-c++ \
	make \
	rpm-build \
	yum-utils
EOT

WORKDIR /root

# binutils
RUN <<EOT
set -e
mkdir -p binutils_rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
echo '%_topdir %(echo $HOME)/binutils_rpmbuild' > .rpmmacros
yumdownloader --source gcc-toolset-13-binutils
rpm -i gcc-toolset-13-binutils*
cd binutils_rpmbuild/SPECS
rpmbuild -bp binutils.spec
cd
mv binutils_rpmbuild/BUILD/binutils-* binutils_src
rm -rf binutils_rpmbuild
EOT

# gcc
RUN <<EOT
set -e
mkdir -p gcc_rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
echo '%_topdir %(echo $HOME)/gcc_rpmbuild' > .rpmmacros
yumdownloader --source gcc-toolset-13-gcc
rpm -i gcc-toolset-13-gcc*
cd gcc_rpmbuild/SPECS
rpmbuild -bp gcc.spec
cd
mv gcc_rpmbuild/BUILD/gcc-* gcc_src
rm -rf gcc_rpmbuild
EOT
