# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10,11} )
inherit distutils-r1

DESCRIPTION="Adafruit MicroPython Tool"
HOMEPAGE="https://github.com/scientifichackers/ampy"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="$(python_gen_cond_dep 'dev-python/python-dotenv[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/pyserial[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/click[${PYTHON_USEDEP}]')"

RDEPEND="${DEPEND}"
BDEPEND=""
