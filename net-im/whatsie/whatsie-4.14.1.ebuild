# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit qmake-utils desktop xdg-utils

DESCRIPTION="Qt Based WhatsApp Client"
HOMEPAGE="https://github.com/keshavbhatt/whatsie"

SRC_URI="https://github.com/keshavbhatt/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

S="${WORKDIR}/${P}/src"

DEPEND="x11-libs/libX11 
	x11-libs/libxcb
	dev-qt/qtwebengine[widgets]
	dev-qt/qtpositioning"
	
src_configure()
{
	eqmake5
}

src_install()
{
	emake DESTDIR="${D}" INSTALL_ROOT="${D}" install 
}	

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
