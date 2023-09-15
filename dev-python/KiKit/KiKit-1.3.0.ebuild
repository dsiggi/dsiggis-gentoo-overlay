# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10,11} )
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1 pypi

DESCRIPTION="Automation for KiCAD boards"
HOMEPAGE="https://github.com/yaqwsx/KiKit"
SRC_URI="$(pypi_sdist_url --no-normalize "${PN}" "${PV}")"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-python/numpy-1.12
	>=dev-python/shapely-1.7
	>=dev-python/click-7.1
	>=dev-python/markdown2-2.4
	>=dev-python/commentjson-0.9
	=dev-python/pcbnewTransition-0.2.0
	>=dev-python/pybars3-0.9
	>=dev-python/solidpython-1.1.2
	$(python_gen_cond_dep 'sci-electronics/kicad[${PYTHON_USEDEP}]')"

LICENSE="MIT"
SLOT="0"

S=${WORKDIR}/${P}
