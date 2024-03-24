# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{11,12} )

inherit distutils-r1 pypi

DESCRIPTION="Library that allows you to support both, KiCAD 5 and KiCAD 6 in your plugins"
HOMEPAGE="https://github.com/yaqwsx/pcbnewTransition"
SRC_URI="$(pypi_sdist_url --no-normalize "${PN}" "${PV}")"
KEYWORDS="~amd64 ~x86"
IUSE=""

LICENSE="MIT"
SLOT="0"

DEPEND="$(python_gen_cond_dep 'dev-python/versioneer[${PYTHON_USEDEP}]')"

S=${WORKDIR}/${P}
