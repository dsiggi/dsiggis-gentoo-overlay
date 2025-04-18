# Copyright 2020-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=7

PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

MY_PN="XStatic-term.js"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="term.js javascript library packaged for setuptools (easy_install)/pip"
HOMEPAGE="https://pypi.org/project/XStatic-term.js"
SRC_URI="$(pypi_sdist_url --no-normalize "${MY_PN}" "${PV^}")"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/xstatic[${PYTHON_USEDEP}]"

DEPEND="
	${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_P}"

python_install() {
	distutils-r1_python_install
	find "${ED}" -name '*.pth' -delete || die
}
