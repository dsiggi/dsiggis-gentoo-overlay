# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1 pypi

DESCRIPTION="Automation for KiCAD boards"
HOMEPAGE="https://github.com/yaqwsx/KiKit"
SRC_URI="$(pypi_sdist_url --no-normalize "${PN}" "${PV}")"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="(
		>=sci-electronics/pcbnewTransition-0.3.4-r1[${PYTHON_SINGLE_USEDEP}]
		$(python_gen_cond_dep '>=dev-python/shapely-1.7[${PYTHON_USEDEP}]')
		$(python_gen_cond_dep 'dev-python/click[${PYTHON_USEDEP}]')
		$(python_gen_cond_dep 'dev-python/markdown2[${PYTHON_USEDEP}]')
		$(python_gen_cond_dep 'dev-python/pybars3[${PYTHON_USEDEP}]')
		$(python_gen_cond_dep 'sci-libs/solidpython2-legacy[${PYTHON_USEDEP}]')
		$(python_gen_cond_dep '>=dev-python/commentjson-0.9[${PYTHON_USEDEP}]')
		sci-electronics/kicad[${PYTHON_SINGLE_USEDEP}]
		!sci-libs/solidpython
		)"

LICENSE="MIT"
SLOT="0"

S=${WORKDIR}/${P}
