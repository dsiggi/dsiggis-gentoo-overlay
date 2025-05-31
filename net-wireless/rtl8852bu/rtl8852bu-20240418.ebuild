# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1

COMMIT="42de963695ffc7929a4905aed5c5d7da7c1c2715"
DESCRIPTION="Linux Driver for USB WiFi Adapters that are based on the RTL8832BU and RTL8852BU Chipsets - v1.19.14-127 - 20240418"
HOMEPAGE="https://github.com/morrownr/rtl8852bu-20240418"
SRC_URI="https://github.com/morrownr/${P}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${P}-${COMMIT}

LICENSE="GPL-2"
SLOT=0
KEYWORDS="~amd64 ~x86"

src_compile() {
	linux-mod-r1_pkg_setup

	local modlist=( 8852bu=net/wireless )
	local modargs=( KSRC="${KV_OUT_DIR}" )
	linux-mod-r1_src_compile
}
