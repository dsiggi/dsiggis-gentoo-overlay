# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10,11} )

inherit distutils-r1

DESCRIPTION="Python interface to the OpenSCAD declarative geometry language"
HOMEPAGE="https://github.com/SolidCode/SolidPython"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-python/prettytable-0.7.2
	>=dev-python/ply-3.11
	>=dev-python/pypng-0.0.19
	>=dev-python/euclid3-0.01"

LICENSE="lgpl-2.1"
SLOT="0"
