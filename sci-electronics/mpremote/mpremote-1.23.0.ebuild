# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=hatchling

inherit distutils-r1 pypi

DESCRIPTION="MicroPython remote control"
HOMEPAGE="https://github.com/micropython/micropython/tree/master/tools/mpremote"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-python/pyserial[${PYTHON_USEDEP}]
	dev-python/importlib-metadata[${PYTHON_USEDEP}]
"

PATCHES=(
	"${FILESDIR}/${P}-requirements_txt.patch"
)
