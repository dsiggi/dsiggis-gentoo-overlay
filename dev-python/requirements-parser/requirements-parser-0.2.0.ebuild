# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="Parses Pip requirement files"
HOMEPAGE="https://github.com/davidfischer/requirements-parser"
SRC_URI="$(pypi_sdist_url --no-normalize "${PN}" "${PV^}")"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S=${WORKDIR}/${P}
