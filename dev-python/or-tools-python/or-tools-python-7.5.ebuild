# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1

DESCRIPTION="Google OR-Tools python libraries and modules"
HOMEPAGE="https://pypi.org/project/ortools/ https://developers.google.com/optimization/"
SRC_URI="https://github.com/google/${PN%%-python}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/gflags/gflags/archive/v2.2.2.tar.gz -> gflags-2.2.2.tar.gz
	https://github.com/google/glog/archive/v0.4.0.tar.gz -> glog-0.4.0.tar.gz
	https://github.com/protocolbuffers/protobuf/archive/v3.11.2.tar.gz -> protobuf-3.11.2.tar.gz
	https://github.com/abseil/abseil-cpp/archive/8ba96a8.tar.gz -> abseil-cpp.tar.gz
	https://github.com/NixOS/patchelf/archive/0.10.tar.gz -> patchelf-0.10.tar.gz
	https://github.com/coin-or/Cbc/archive/releases/2.10.3.tar.gz -> Cbc-2.10.3.tar.gz
	https://github.com/coin-or/Cgl/archive/releases/0.60.2.tar.gz -> Cgl-0.60.2.tar.gz
	https://github.com/coin-or/Clp/archive/releases/1.17.3.tar.gz -> Clp-1.17.3.tar.gz
	https://github.com/coin-or/Osi/archive/releases/0.108.4.tar.gz -> Osi-0.108.4.tar.gz
	https://github.com/coin-or/CoinUtils/archive/releases/2.11.2.tar.gz -> CoinUtils-2.11.2.tar.gz"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE=""

LICENSE="Apache-2.0"
SLOT="0"

DEPEND="dev-python/mypy-protobuf
	dev-python/pip"

S="${WORKDIR}/${PN%%-python}-${PV}"

src_prepare() {
	DEPTREE=${S}/dependencies/sources/.temp
	MAKEFILE=${S}/makefiles/Makefile.third_party.unix.mk

	default

	#Move unpacked sources 
	mkdir ${DEPTREE}
	mv ${WORKDIR}/Cbc-releases-2.10.3 ${DEPTREE}/Cbc-2.10.3
	mv ${WORKDIR}/Cgl-releases-0.60.2 ${DEPTREE}/Cgl-0.60.2
	mv ${WORKDIR}/Clp-releases-1.17.3 ${DEPTREE}/Clp-1.17.3
	mv ${WORKDIR}/CoinUtils-releases-2.11.2 ${DEPTREE}/CoinUtils-2.11.2
	mv ${WORKDIR}/gflags-2.2.2 ${DEPTREE}/
	mv ${WORKDIR}/glog-0.4.0 ${DEPTREE}/
	mv ${WORKDIR}/Osi-releases-0.108.4 ${DEPTREE}/Osi-0.108.4
	mv ${WORKDIR}/patchelf-0.10 ${DEPTREE}/
	mv ${WORKDIR}/protobuf-3.11.2 ${DEPTREE}/
	mv ${WORKDIR}/abseil-cpp-8ba96a8244bbe334d09542e92d566673a65c1f78 ${DEPTREE}/abseil-cpp-8ba96a8

	#Add decleartion of ${DEPTREE} to the makefile
	sed -i "32iDEPTREE := ${DEPTREE}" ${MAKEFILE}

	#Change all git commands to mv commands
	sed -i 's?.*-b releases/$(CBC_TAG).*?\tmv ${DEPTREE}/Cbc-2.10.3 ${DEPTREE}/../?' ${MAKEFILE} || die
	sed -i 's?.*-b releases/$(CGL_TAG).*?\tmv ${DEPTREE}/Cgl-0.60.2 ${DEPTREE}/../?' ${MAKEFILE} || die
	sed -i 's?.*-b releases/$(CLP_TAG).*?\tmv ${DEPTREE}/Clp-1.17.3 ${DEPTREE}/../?' ${MAKEFILE} || die
	sed -i 's?.*-b releases/$(COINUTILS_TAG).*?\tmv ${DEPTREE}/CoinUtils-2.11.2 ${DEPTREE}/../?' ${MAKEFILE} || die
	sed -i 's?.*-b v$(GFLAGS_TAG).*?\tmv ${DEPTREE}/gflags-2.2.2 ${DEPTREE}/../?' ${MAKEFILE} || die
	sed -i 's?.*-b v$(GLOG_TAG).*?\tmv ${DEPTREE}/glog-0.4.0 ${DEPTREE}/../?' ${MAKEFILE} || die
	sed -i 's?.*-b releases/$(OSI_TAG).*?\tmv ${DEPTREE}/Osi-0.108.4 ${DEPTREE}/../?' ${MAKEFILE} || die
	sed -i 's?.*-b $(PATCHELF_TAG).*?\tmv ${DEPTREE}/patchelf-0.10 ${DEPTREE}/../?' ${MAKEFILE} || die
	sed -i 's?.*-b v$(PROTOBUF_TAG).*?\tmv ${DEPTREE}/protobuf-3.11.2 ${DEPTREE}/../?' ${MAKEFILE} || die
	sed -i 's?.*--quiet https://github.com/abseil.*?\tmv ${DEPTREE}/abseil-cpp-8ba96a8 ${DEPTREE}/../?' ${MAKEFILE} || die

	#Remoce not needed git commands
	sed -i 's?cd dependencies/sources/abseil-cpp-$(ABSL_TAG) && git reset --hard $(ABSL_TAG)??' ${MAKEFILE} || die

}

src_compile() {
	elog "Compiling third_party"
	emake third_party
	elog "Compiling python"
	emake python
	elog "Compiling pypi_archive"
	emake pypi_archive
}

src_install() {
	emake install_python
	/usr/bin/pip install --root=${D} --no-deps --ignore-installed --no-warn-script-location "$(find -name 'ortools*whl')"
}
