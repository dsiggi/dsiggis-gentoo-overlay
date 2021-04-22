# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_{8,9} )

inherit distutils-r1

DESCRIPTION="Discord RPC client written in Python"
HOMEPAGE="https://pypi.org/project/pypresence/ https://github.com/qwertyquerty/pypresence"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE=""

LICENSE="MIT"
SLOT="0"
