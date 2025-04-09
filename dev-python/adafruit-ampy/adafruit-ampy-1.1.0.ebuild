# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
inherit distutils-r1 pypi

DESCRIPTION="Adafruit MicroPython Tool"
HOMEPAGE="https://github.com/scientifichackers/ampy"
#SRC_URI="https://github.com/scientifichackers/ampy/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI="$(pypi_sdist_url --no-normalize "${PN}" "${PV}")"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="$(python_gen_cond_dep 'dev-python/python-dotenv[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/pyserial[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/click[${PYTHON_USEDEP}]')"

RDEPEND="${DEPEND}"
BDEPEND=""

S=${WORKDIR}/${P}
