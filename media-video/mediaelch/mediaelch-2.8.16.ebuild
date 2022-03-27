# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7
inherit qmake-utils eutils desktop xdg-utils

QUAZIP_VERSION="1.1"
MY_PN=MediaElch
S=$WORKDIR/$MY_PN-$PV

DESCRIPTION="Video metadata scraper"
SRC_URI="https://github.com/Komet/$MY_PN/archive/v${PV}.tar.gz -> $P.tar.gz
	https://github.com/stachenov/quazip/archive/refs/tags/v${QUAZIP_VERSION}.tar.gz -> quazip-${QUAZIP_VERSION}.tar.gz"
HOMEPAGE="http://www.mediaelch.de/"
SLOT="0"
LICENSE="GPL-3"
KEYWORDS="amd64 x86"

DEPEND="dev-qt/qtsql:5
	dev-qt/qtscript:5
	dev-qt/qtquickcontrols:5
	dev-qt/qtxmlpatterns:5
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	media-video/mediainfo
	media-libs/libzen
	dev-qt/qtconcurrent:5
	dev-qt/qtmultimedia:5[widgets]
	dev-qt/qtscript:5"

src_unpack()
{
	unpack $P.tar.gz
	unpack quazip-${QUAZIP_VERSION}.tar.gz
	cd $S/third_party
	rmdir quazip
	mv $WORKDIR/quazip-${QUAZIP_VERSION} quazip
}

src_configure()
{
	cd $S || die
	eqmake5 || die
}

src_install()
{
	dobin $S/MediaElch

	doicon $S/data/desktop/MediaElch.png
	domenu $S/data/desktop/MediaElch.desktop
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
