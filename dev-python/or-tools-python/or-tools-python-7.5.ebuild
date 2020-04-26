# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_{6,7} )

V_gflags=2.2.2
V_glog=0.4.0
V_protobuf=3.11.2
V_abseil=8ba96a8
V_patchelf=0.10
V_Cbc=2.10.3
V_Cgl=0.60.2
V_Clp=1.17.3
V_Osi=0.108.4
V_CoinUtils=2.11.2

inherit python-r1 multibuild

DESCRIPTION="Google OR-Tools python libraries and modules"
HOMEPAGE="https://pypi.org/project/ortools/ https://developers.google.com/optimization/"
SRC_URI="https://github.com/google/${PN%%-python}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/gflags/gflags/archive/v${V_gflags}.tar.gz -> gflags-${V_gflags}.tar.gz
	https://github.com/google/glog/archive/v${V_glog}.tar.gz -> glog-${V_glog}.tar.gz
	https://github.com/protocolbuffers/protobuf/archive/v${V_protobuf}.tar.gz -> protobuf-${V_protobuf}.tar.gz
	https://github.com/abseil/abseil-cpp/archive/${V_abseil}.tar.gz -> abseil-cpp.tar.gz
	https://github.com/NixOS/patchelf/archive/${V_patchelf}.tar.gz -> patchelf-${V_patchelf}.tar.gz
	https://github.com/coin-or/Cbc/archive/releases/${V_Cbc}.tar.gz -> Cbc-${V_Cbc}.tar.gz
	https://github.com/coin-or/Cgl/archive/releases/${V_Cgl}.tar.gz -> Cgl-${V_Cgl}.tar.gz
	https://github.com/coin-or/Clp/archive/releases/${V_Clp}.tar.gz -> Clp-${V_Clp}.tar.gz
	https://github.com/coin-or/Osi/archive/releases/${V_Osi}.tar.gz -> Osi-${V_Osi}.tar.gz
	https://github.com/coin-or/CoinUtils/archive/releases/${V_CoinUtils}.tar.gz -> CoinUtils-${V_CoinUtils}.tar.gz"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE=""

LICENSE="Apache-2.0"
SLOT="0"

DEPEND="$(python_gen_cond_dep 'dev-python/mypy-protobuf[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/pip[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/wheel[${PYTHON_USEDEP}]')
	"

S="${WORKDIR}/${PN%%-python}-${PV}"

src_unpack() {
	copy_deps() {
		DEPTREE=${BUILD_DIR}/dependencies/sources/.temp
		cp -r ${S}/* ${BUILD_DIR}/
		mkdir ${DEPTREE}

		for f in ${A}; do
			#or-tools nicht abarbeiten
			if ! [ "$f" == "${P}.tar.gz" ]; then
				cp -r ${WORKDIR}/${f%%-*}* ${DEPTREE}
			fi 	
		done

	}

	unpack ${A}
	#Manche Verzeichnisse müssen umbenannt werden
	mv ${WORKDIR}/Cbc* ${WORKDIR}/Cbc-${V_Cbc}
	mv ${WORKDIR}/Cgl* ${WORKDIR}/Cgl-${V_Cgl}
	mv ${WORKDIR}/Clp* ${WORKDIR}/Clp-${V_Clp}
	mv ${WORKDIR}/CoinUtils* ${WORKDIR}/CoinUtils-${V_CoinUtils}
	mv ${WORKDIR}/Osi* ${WORKDIR}/Osi-${V_Osi}
	mv ${WORKDIR}/abseil-cpp-* ${WORKDIR}/abseil-cpp-${V_abseil}

	python_foreach_impl run_in_build_dir copy_deps
	
	#Aufräumen
	for f in ${A}; do
		#or-tools nicht abarbeiten
		if ! [ "$f" == "${P}.tar.gz" ]; then
			rm -r ${WORKDIR}/${f%%-*}*
		fi
	done
}

src_prepare() {
	prepare() {
		DEPTREE=${BUILD_DIR}/dependencies/sources/.temp
		MAKEFILE=${BUILD_DIR}/makefiles/Makefile.third_party.unix.mk

		default

		#Add decleartion of ${DEPTREE} to the makefile
		sed -i "32iDEPTREE := ${DEPTREE}" ${MAKEFILE}

		#Alle git-Befehle zu mv-Befehlen ändern
		sed -i 's?.*-b releases/$(CBC_TAG).*?\tmv ${DEPTREE}/Cbc-${CBC_TAG} ${DEPTREE}/../?' ${MAKEFILE} || die
		sed -i 's?.*-b releases/$(CGL_TAG).*?\tmv ${DEPTREE}/Cgl-${CGL_TAG} ${DEPTREE}/../?' ${MAKEFILE} || die
		sed -i 's?.*-b releases/$(CLP_TAG).*?\tmv ${DEPTREE}/Clp-${CLP_TAG} ${DEPTREE}/../?' ${MAKEFILE} || die
		sed -i 's?.*-b releases/$(COINUTILS_TAG).*?\tmv ${DEPTREE}/CoinUtils-${COINUTILS_TAG} ${DEPTREE}/../?' ${MAKEFILE} || die
		sed -i 's?.*-b v$(GFLAGS_TAG).*?\tmv ${DEPTREE}/gflags-${GFLAGS_TAG} ${DEPTREE}/../?' ${MAKEFILE} || die
		sed -i 's?.*-b v$(GLOG_TAG).*?\tmv ${DEPTREE}/glog-${GLOG_TAG} ${DEPTREE}/../?' ${MAKEFILE} || die
		sed -i 's?.*-b releases/$(OSI_TAG).*?\tmv ${DEPTREE}/Osi-${OSI_TAG} ${DEPTREE}/../?' ${MAKEFILE} || die
		sed -i 's?.*-b $(PATCHELF_TAG).*?\tmv ${DEPTREE}/patchelf-${PATCHELF_TAG} ${DEPTREE}/../?' ${MAKEFILE} || die
		sed -i 's?.*-b v$(PROTOBUF_TAG).*?\tmv ${DEPTREE}/protobuf-${PROTOBUF_TAG} ${DEPTREE}/../?' ${MAKEFILE} || die
		sed -i 's?.*--quiet https://github.com/abseil.*?\tmv ${DEPTREE}/abseil-cpp-${ABSL_TAG} ${DEPTREE}/../?' ${MAKEFILE} || die

		#Nicht benötigte git-Befehle entfernen
		sed -i 's?cd dependencies/sources/abseil-cpp-$(ABSL_TAG) && git reset --hard $(ABSL_TAG)??' ${MAKEFILE} || die
	}

	python_foreach_impl run_in_build_dir prepare
}

src_compile() {
	python_foreach_impl run_in_build_dir emake third_party
	python_foreach_impl run_in_build_dir emake python
	python_foreach_impl run_in_build_dir emake pypi_archive
}

src_install() {
	python_foreach_impl run_in_build_dir emake install_python

	pip() {
		file=$(find ${BUILD_DIR} -name 'ortools-*.whl')
		/usr/bin/pip install --root=${D} --no-deps --ignore-installed --no-warn-script-location ${file}
	}
	
	python_foreach_impl run_in_build_dir pip
}
