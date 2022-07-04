# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{9,10} )

V_gflags=2.2.2
V_glog=0.4.0
V_protobuf=v3.15.8
V_abseil=20210324.1
V_patchelf=0.10
V_Cbc=2.10.5
V_Cgl=0.60.3
V_Clp=1.17.4
V_Osi=0.108.6
V_CoinUtils=2.11.4
V_Scip=7.0.1

inherit python-r1 multibuild #cmake

DESCRIPTION="Google OR-Tools python libraries and modules"
HOMEPAGE="https://pypi.org/project/ortools/ https://developers.google.com/optimization/"
SRC_URI="https://github.com/google/${PN%%-python}/archive/v${PV%.*}.tar.gz -> ${P}.tar.gz
	https://github.com/gflags/gflags/archive/v${V_gflags}.tar.gz -> gflags-${V_gflags}.tar.gz
	https://github.com/google/glog/archive/v${V_glog}.tar.gz -> glog-${V_glog}.tar.gz
	https://github.com/protocolbuffers/protobuf/archive/${V_protobuf}.tar.gz -> protobuf-${V_protobuf}.tar.gz
	https://github.com/abseil/abseil-cpp/archive/${V_abseil}.tar.gz -> abseil-cpp-${V_abseil}.tar.gz
	https://github.com/NixOS/patchelf/archive/${V_patchelf}.tar.gz -> patchelf-${V_patchelf}.tar.gz
	https://github.com/coin-or/Cbc/archive/releases/${V_Cbc}.tar.gz -> Cbc-${V_Cbc}.tar.gz
	https://github.com/coin-or/Cgl/archive/releases/${V_Cgl}.tar.gz -> Cgl-${V_Cgl}.tar.gz
	https://github.com/coin-or/Clp/archive/releases/${V_Clp}.tar.gz -> Clp-${V_Clp}.tar.gz
	https://github.com/coin-or/Osi/archive/releases/${V_Osi}.tar.gz -> Osi-${V_Osi}.tar.gz
	https://github.com/coin-or/CoinUtils/archive/releases/${V_CoinUtils}.tar.gz -> CoinUtils-${V_CoinUtils}.tar.gz"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE="-scip"

LICENSE="Apache-2.0
	scip? ( ZIB_Academic_License )"
SLOT="0"

DEPEND="$(python_gen_cond_dep 'dev-python/mypy-protobuf[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/pip[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/wheel[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep '>=dev-python/protobuf-python-3.13.0[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/absl-py[${PYTHON_USEDEP}]')
	"

S="${WORKDIR}/${PN%%-python}-${PV%.*}"

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
	#mv ${WORKDIR}/abseil-cpp-* ${WORKDIR}/abseil-cpp-${V_abseil}
	mv ${WORKDIR}/protobuf* ${WORKDIR}/protobuf-${V_protobuf}

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
		zeile=$(expr $(grep -n "Tags of dep" ${MAKEFILE} | cut -d":" -f1) - 1)
		sed -i "${zeile}iDEPTREE := ${DEPTREE}" ${MAKEFILE}
		zeile=$(grep -n "DEPTREE" ${MAKEFILE} | cut -d":" -f1 | head -n1)
		sed -i "${zeile}iFILESDIR := ${FILESDIR}" ${MAKEFILE}


		#Alle git-Befehle zu mv-Befehlen ändern
		sed -i 's?.*-b releases/$(CBC_TAG).*?\tmv ${DEPTREE}/Cbc-${CBC_TAG} ${DEPTREE}/../?' ${MAKEFILE} || die
		sed -i 's?.*-b releases/$(CGL_TAG).*?\tmv ${DEPTREE}/Cgl-${CGL_TAG} ${DEPTREE}/../?' ${MAKEFILE} || die
		sed -i 's?.*-b releases/$(CLP_TAG).*?\tmv ${DEPTREE}/Clp-${CLP_TAG} ${DEPTREE}/../?' ${MAKEFILE} || die
		sed -i 's?.*-b releases/$(COINUTILS_TAG).*?\tmv ${DEPTREE}/CoinUtils-${COINUTILS_TAG} ${DEPTREE}/../?' ${MAKEFILE} || die
		sed -i 's?.*-b v$(GFLAGS_TAG).*?\tmv ${DEPTREE}/gflags-${GFLAGS_TAG} ${DEPTREE}/../?' ${MAKEFILE} || die
		sed -i 's?.*-b v$(GLOG_TAG).*?\tmv ${DEPTREE}/glog-${GLOG_TAG} ${DEPTREE}/../?' ${MAKEFILE} || die
		sed -i 's?.*-b releases/$(OSI_TAG).*?\tmv ${DEPTREE}/Osi-${OSI_TAG} ${DEPTREE}/../?' ${MAKEFILE} || die
		sed -i 's?.*-b $(PATCHELF_TAG).*?\tmv ${DEPTREE}/patchelf-${PATCHELF_TAG} ${DEPTREE}/../?' ${MAKEFILE} || die
		sed -i 's?.*-b $(PROTOBUF_TAG).*?\tmv ${DEPTREE}/protobuf-${PROTOBUF_TAG} ${DEPTREE}/../?' ${MAKEFILE} || die
		sed -i 's?.*--quiet https://github.com/abseil.*?\tmv ${DEPTREE}/abseil-cpp-${ABSL_TAG} ${DEPTREE}/../?' ${MAKEFILE} || die

		#Nicht benötigte git-Befehle entfernen
		sed -i 's?cd dependencies/sources/abseil-cpp-$(ABSL_TAG) && git reset --hard $(ABSL_TAG)??' ${MAKEFILE} || die

		#Patch für abseil hinzufügen
		zeile=$(expr $(grep -n 'cd dependencies/sources/abseil-cpp-$(ABSL_TAG) && git apply "$(OR_TOOLS_TOP)/patches/abseil-cpp-$(ABSL_TAG).patch"' ${MAKEFILE} | cut -d":" -f1) - 1)
		sed -i "${zeile}i\\\tpatch -p1 < ${FILESDIR}/abseil-cpp-20210324.1-glibc-2.34.patch" ${MAKEFILE} || die

		#Disable Scip
		if use !scip; then
			zeile=$(expr $(grep -n "Tags of dep" ${MAKEFILE} | cut -d":" -f1) - 1)
			sed -i "${zeile}iUSE_SCIP = OFF" ${MAKEFILE}
		fi
	}

	python_foreach_impl run_in_build_dir prepare
}

src_compile() {
	python_foreach_impl run_in_build_dir emake BUILD_SCIP=$(usex scip ON OFF) third_party
	python_foreach_impl run_in_build_dir emake BUILD_SCIP=$(usex scip ON OFF) python
	python_foreach_impl run_in_build_dir emake BUILD_SCIP=$(usex scip ON OFF) pypi_archive
}

src_install() {
	python_foreach_impl run_in_build_dir emake BUILD_SCIP=$(usex scip ON OFF) install_python

	pip() {
		file=$(find ${BUILD_DIR} -name 'ortools-*.whl')
		/usr/bin/pip install --root=${D} --no-deps --ignore-installed --no-warn-script-location ${file}
	}
	
	python_foreach_impl run_in_build_dir pip
}
