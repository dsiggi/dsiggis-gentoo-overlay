# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7
inherit qmake-utils desktop xdg-utils

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

IUSE="qt6 -qt5"

REQUIRED_USE="^^ ( qt5 qt6 )"

DEPEND="dev-qt/qtsql
	dev-qt/qtscript
	dev-qt/qtquickcontrols
	dev-qt/qtxmlpatterns
	dev-qt/qtcore
	dev-qt/qtgui
	media-video/mediainfo
	media-libs/libzen
	dev-qt/qtconcurrent
	dev-qt/qtscript
	qt6? ( dev-qt/qtmultimedia:6 )
	qt5? ( dev-qt/qtmultimedia:5[widgets]
		dev-qt/qtopengl )
"

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
	use qt6 && eqmake6
	use qt5 && eqmake5
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
