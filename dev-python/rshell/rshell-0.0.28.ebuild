# Copyright 1999-2025 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="Remote MicroPython shell"
HOMEPAGE="https://github.com/dhyland/rshell"
SRC_URI="$(pypi_sdist_url "${PN^}" "${PV^}")"

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
