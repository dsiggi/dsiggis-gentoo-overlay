# Copyright 2020-2022 LiGurOs Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=6
PYTHON_COMPAT=( python3_{9,10} )

inherit distutils-r1 user

DESCRIPTION="Python module for LXD "
HOMEPAGE="https://github.com/lxc/pylxd"
SRC_URI="https://github.com/lxc/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~arm ~arm64 x86"
IUSE=""

DEPEND="
	>=dev-python/cryptography-3.2[${PYTHON_USEDEP}]
	>=dev-python/python-dateutil-2.4.2[${PYTHON_USEDEP}]
	>=dev-python/requests-2.20.0[${PYTHON_USEDEP}]
	>=dev-python/requests-toolbelt-0.8.0[${PYTHON_USEDEP}]
	>=dev-python/requests-unixsocket-0.1.5[${PYTHON_USEDEP}]
	>=dev-python/ws4py-0.5[${PYTHON_USEDEP}]
"

RDEPEND="app-containers/lxd ${DEPEND}"
