# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517="setuptools"
DISTUTILS_SINGLE_IMPL=1
inherit distutils-r1 pypi

DESCRIPTION="Library that allows you to support both, KiCAD 5 and KiCAD 6 in your plugins"
HOMEPAGE="https://github.com/yaqwsx/pcbnewTransition"
SRC_URI="$(pypi_sdist_url "${PN}" "${PV}")"
KEYWORDS="~amd64 ~x86"
IUSE=""

LICENSE="MIT"
SLOT="0"

S=${WORKDIR}/${P,,}
