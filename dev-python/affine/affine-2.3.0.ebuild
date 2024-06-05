# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="Matrices describing affine transformation of the plane."
HOMEPAGE="https://pypi.org/project/affine/ https://github.com/sgillies/affine"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE=""

LICENSE="BSD"
SLOT="0"
