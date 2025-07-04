# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1

inherit distutils-r1 pypi

DESCRIPTION="Generate mypy stub files from protobuf specs"
HOMEPAGE="https://pypi.org/project/mypy-protobuf/ https://github.com/dropbox/mypy-protobuf"
SRC_URI="$(pypi_sdist_url --no-normalize "${PN}" "${PV}")"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE=""

DEPEND="dev-python/protobuf[${PYTHON_USEDEP}]"

LICENSE="Apache-2.0"
SLOT="0"
