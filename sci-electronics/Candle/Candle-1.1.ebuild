# Copyright 1999-2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7
inherit qmake-utils eutils desktop xdg-utils


DESCRIPTION="GRBL controller application with G-Code visualizer written in Qt."
SRC_URI="https://github.com/Denvi/${PN}/archive/v${PV}.tar.gz"
HOMEPAGE="https://github.com/Denvi/Candle/"
SLOT="0"
LICENSE="GPL-3"
KEYWORDS="amd64 x86"

DEPEND="dev-libs/glib
	dev-qt/qtserialport:5
	dev-qt/qtgui:5
	dev-qt/qtcore:5
	dev-qt/qtwidgets:5
	dev-qt/qtopengl:5"

S=${WORKDIR}/${P}/src

src_compile()
{
	eqmake5 || die
	emake || die
}

src_install()
{
	exeinto /opt/bin
	doexe Candle

	newicon images/candle_256.png Candle.png
	make_desktop_entry /opt/bin/Candle Candle Candle.png Electronics
}

pkg_postinst()
{
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm()
{
	xdg_desktop_database_update
	xdg_icon_cache_update
}
