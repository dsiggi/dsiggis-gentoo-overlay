# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10,11} )

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

inherit python-r1 multibuild cmake

DESCRIPTION="Google OR-Tools python libraries and modules"
HOMEPAGE="https://pypi.org/project/ortools/ https://developers.google.com/optimization/"
SRC_URI="https://github.com/google/${PN%%-python}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64 ~x86 ~arm"
IUSE="-coinor -glpk"

LICENSE="Apache-2.0"
SLOT="0"

DEPEND="$(python_gen_cond_dep 'dev-python/mypy-protobuf[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/pip[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/wheel[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep '>=dev-python/protobuf-python-3.13.0[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/absl-py[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/pybind11[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/pandas[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/matplotlib[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/pytest[${PYTHON_USEDEP}]')
	sys-libs/zlib
	dev-libs/protobuf
	dev-lang/swig
	>=dev-cpp/abseil-cpp-20230125.2
	coinor? ( sci-libs/coinor-cbc )
	glpk? ( sci-mathematics/glpk )
	"

S="${WORKDIR}/${PN%%-python}-${PV}"

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_DOTNET=OFF
		-DBUILD_CXX=ON
		-DBUILD_JAVA=OFF
		-DBUILD_PYTHON=ON
		-DBUILD_ZLIB=OFF
		-DBUILD_DEPS=OFF
		-DUSE_SCIP=OFF
		-DBUILD_TESTING=OFF
		-DUSE_COINOR=$(usex coinor ON OFF)
		-DUSE_GLPK=$(usex glpk ON OFF)
		)
		
	python_foreach_impl run_in_build_dir cmake_src_configure
}



src_compile() {
	python_foreach_impl run_in_build_dir cmake_src_compile
}

src_install() {
	install() {
		cmake_src_install
		python_optimize
	}
	
	python_foreach_impl install
}

