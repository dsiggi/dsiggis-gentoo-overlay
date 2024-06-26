# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=7

PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

MY_PN="XStatic-term.js"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="term.js javascript library packaged for setuptools (easy_install)/pip"
HOMEPAGE="https://pypi.org/project/XStatic-term.js"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz -> ${P}.tar.gz"

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
