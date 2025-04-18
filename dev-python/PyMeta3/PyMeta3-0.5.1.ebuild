# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="Pattern-matching language based on OMeta for Python 3 and 2"
HOMEPAGE="https://github.com/wbond/pymeta3"
SRC_URI="$(pypi_sdist_url --no-normalize "${PN^}" "${PV^}")"
KEYWORDS="~amd64 ~x86"
IUSE=""

LICENSE="MIT"
SLOT="0"

S=${WORKDIR}/${P^}
