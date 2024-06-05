# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="A pure-Python library for reading and converting SVG"
HOMEPAGE="https://pypi.org/project/svglib/ https://github.com/deeplook/svglib"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE=""

LICENSE="GPLv2"
SLOT="0"
