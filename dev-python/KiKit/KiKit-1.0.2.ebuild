# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_{9,10} )

inherit distutils-r1

DESCRIPTION="Automation for KiCAD boards"
HOMEPAGE="https://github.com/yaqwsx/KiKit"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-python/numpy-1.12
	>=dev-python/shapely-1.7
	>=dev-python/click-7.1
	>=dev-python/markdown2-2.4
	>=dev-python/commentjson-0.9
	=dev-python/pcbnewTransition-0.2.0
	>=dev-python/pybars3-0.9
	>=dev-python/solidpython-1.1.2"

LICENSE="MIT"
SLOT="0"
