# Copyright 2020-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=7
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1

DESCRIPTION="XStatic base package with minimal support code"
HOMEPAGE="https://pypi.org/project/XStatic"
SRC_URI="https://github.com/xstatic-py/xstatic/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

python_install() {
	distutils-r1_python_install
	find "${ED}" -name '*.pth' -delete || die
}
