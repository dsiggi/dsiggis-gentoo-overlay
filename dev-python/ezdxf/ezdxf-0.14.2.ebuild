# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..12} )

DISTUTILS_USE_SETUPTOOLS=rdepend
inherit distutils-r1

DESCRIPTION="A Python package to create/manipulate DXF drawings"
HOMEPAGE="https://pypi.org/project/ezdxf https://ezdxf.mozman.at/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE=""

DEPEND="dev-python/wheel[${PYTHON_USEDEP}]"

LICENSE="MIT"
SLOT="0"
