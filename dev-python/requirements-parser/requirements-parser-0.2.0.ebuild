# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{10..12} )
inherit distutils-r1

DESCRIPTION="Parses Pip requirement files"
HOMEPAGE="https://github.com/davidfischer/requirements-parser"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
