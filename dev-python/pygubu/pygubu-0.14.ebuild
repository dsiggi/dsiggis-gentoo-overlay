# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="A simple GUI designer for the python tkinter module"
HOMEPAGE="https://github.com/alejandroautalan/pygubu"
SRC_URI="$(pypi_sdist_url "${PN^}" "${PV^}")"
KEYWORDS="~amd64 ~x86"
IUSE=""

LICENSE="MIT"
SLOT="0"
