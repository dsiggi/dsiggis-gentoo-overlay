# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="Discord RPC client written in Python"
HOMEPAGE="https://pypi.org/project/pypresence/ https://github.com/qwertyquerty/pypresence"
SRC_URI="$(pypi_sdist_url "${PN^}" "${PV^}")"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE=""

LICENSE="MIT"
SLOT="0"
