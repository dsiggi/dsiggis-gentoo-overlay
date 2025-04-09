# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..13} )

DISTUTILS_USE_SETUPTOOLS=rdepend
inherit distutils-r1

DESCRIPTION="A Python package to create/manipulate DXF drawings"
HOMEPAGE="https://pypi.org/project/ezdxf https://ezdxf.mozman.at/"
SRC_URI="https://github.com/mozman/ezdxf/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE=""

DEPEND="dev-python/wheel[${PYTHON_USEDEP}]"

LICENSE="MIT"
SLOT="0"
