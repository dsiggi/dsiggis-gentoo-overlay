# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9,10} )
inherit distutils-r1

DESCRIPTION="When they're not builtins, they're boltons."
HOMEPAGE="https://github.com/mahmoud/boltons/releases"
SRC_URI="https://github.com/mahmoud/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

