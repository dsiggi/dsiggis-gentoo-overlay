# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1

inherit distutils-r1

DESCRIPTION="Google OR-Tools python libraries and modules"
HOMEPAGE="https://pypi.org/project/ortools/ https://developers.google.com/optimization/"
SRC_URI="https://github.com/google/or-tools/releases/download/v9.10/ortools-${PV}-cp312-cp312-manylinux_2_17_x86_64.manylinux2014_x86_64.whl"

KEYWORDS="~amd64"
IUSE="-coinor -glpk"

LICENSE="Apache-2.0"
SLOT="0"

DEPEND="dev-python/mypy-protobuf[${PYTHON_USEDEP}]
	dev-python/pip[${PYTHON_USEDEP}]
	dev-python/wheel[${PYTHON_USEDEP}]
	>=dev-python/protobuf-python-3.13.0[${PYTHON_USEDEP}]
	dev-python/absl-py[${PYTHON_USEDEP}]
	dev-python/pybind11[${PYTHON_USEDEP}]
	dev-python/pandas[${PYTHON_USEDEP}]
	dev-python/matplotlib[${PYTHON_USEDEP}]
	dev-python/pytest[${PYTHON_USEDEP}]
	sys-libs/zlib
	dev-libs/protobuf
	dev-lang/swig
	>=dev-cpp/abseil-cpp-20230125.2
	coinor? ( sci-libs/coinor-cbc )
	glpk? ( sci-mathematics/glpk )
	dev-libs/re2
	sci-misc/HiGHS
	"

src_unpack() {
   #default_src_unpack
   # Make empty S directory
   [ ! -d "${WORKDIR}"/"${P}" ] && mkdir "${WORKDIR}"/"${P}"
}

python_compile() {
	distutils_wheel_install "${BUILD_DIR}/install" \
      "${DISTDIR}/ortools-${PV}-cp312-cp312-manylinux_2_17_x86_64.manylinux2014_x86_64.whl"
}

python_install() {

	cp -R ${BUILD_DIR}/install/* ${D}/
}
