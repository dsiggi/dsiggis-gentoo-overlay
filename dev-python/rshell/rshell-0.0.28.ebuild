# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{10..12} )

DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1

DESCRIPTION="Remote MicroPython shell"
HOMEPAGE="https://github.com/dhyland/rshell"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~x86"
IUSE=""

DEPEND="$(python_gen_cond_dep 'dev-python/pyserial[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/pyudev[${PYTHON_USEDEP}]')"

src_prepare() {
		# remove the tests package from being installed
		sed -i "s/, 'tests'//g" setup.py || die
		eapply_user
}
