# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{9,10} )

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
