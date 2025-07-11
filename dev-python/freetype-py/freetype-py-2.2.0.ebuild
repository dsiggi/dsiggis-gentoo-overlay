# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="Freetype python bindings"
HOMEPAGE="https://pypi.org/project/freetype-py/ https://github.com/rougier/freetype-py"
SRC_URI="$(pypi_sdist_url --no-normalize "${PN}" "${PV^}" ".zip")"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE=""

DEPEND="dev-python/wheel[${PYTHON_USEDEP}]
	dev-python/setuptools_scm_git_archive[${PYTHON_USEDEP}]
	dev-python/toml[${PYTHON_USEDEP}]"

LICENSE="BSD"
SLOT="0"

S=${WORKDIR}/${P}
