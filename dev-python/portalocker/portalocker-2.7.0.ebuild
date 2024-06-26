# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{10..12} )
inherit distutils-r1 pypi

DESCRIPTION="Wraps the portalocker recipe for easy usage"
HOMEPAGE="https://github.com/WoLpH/portalocker"
SRC_URI="$(pypi_sdist_url "${PN^}" "${PV}")"

LICENSE="PSF-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

