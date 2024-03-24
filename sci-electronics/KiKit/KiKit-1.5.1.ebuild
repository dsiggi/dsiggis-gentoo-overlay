# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{11,12} )
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1 pypi

DESCRIPTION="Automation for KiCAD boards"
HOMEPAGE="https://github.com/yaqwsx/KiKit"
SRC_URI="$(pypi_sdist_url --no-normalize "${PN}" "${PV}")"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="(
		>=sci-electronics/pcbnewTransition-0.3.4-r1
		>=dev-python/shapely-1.7
		>=dev-python/click-7.1
		>=dev-python/markdown2-2.4
		>=dev-python/pybars3-0.9
		sci-libs/solidpython2-legacy
		!sci-libs/solidpython
		>=dev-python/commentjson-0.9
		media-gfx/openscad
		sci-electronics/kicad
		)"

LICENSE="MIT"
SLOT="0"

S=${WORKDIR}/${P}
