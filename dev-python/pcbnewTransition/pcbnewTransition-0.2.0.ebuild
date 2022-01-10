# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_{9,10} )

inherit distutils-r1

DESCRIPTION="Library that allows you to support both, KiCAD 5 and KiCAD 6 in your plugins"
HOMEPAGE="https://github.com/yaqwsx/pcbnewTransition"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
IUSE=""

LICENSE="MIT"
SLOT="0"