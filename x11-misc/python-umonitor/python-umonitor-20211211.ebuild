# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_SINGLE_IMPL=1

DISTUTILS_USE_SETUPTOOLS=rdepend
inherit distutils-r1

DESCRIPTION="Manage monitor configuration automatically."
HOMEPAGE="https://github.com/rliou92/python-umonitor"
COMMIT="ea7473d9df09bf1cbc0dfca61984313f170f722e"
SRC_URI="https://github.com/rliou92/${PN}/archive/${COMMIT}.zip -> ${P}.zip"
KEYWORDS="~amd64 ~x86"
IUSE=""

LICENSE="MIT"
SLOT="0"

DEPEND="$(python_gen_cond_dep 'dev-python/python-daemon[${PYTHON_USEDEP}]')"

S=${WORKDIR}/${PN}-${COMMIT}
