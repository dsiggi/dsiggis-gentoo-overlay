# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: 

EAPI=6

inherit eutils qmake-utils xdg-utils

DESCRIPTION="A free, open source, cross-platform video editor"
HOMEPAGE="http://www.shotcut.org/"
SRC_URI="https://github.com/mltframework/${PN}/archive/v${PV}.tar.gz -> ${P}.txz"

LICENSE="GPL-3"

SLOT="0"

KEYWORDS="~x86 ~amd64"

IUSE=""

BDEPEND="dev-qt/linguist-tools:5"

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgraphicaleffects:5
	dev-qt/qtgui:5
	dev-qt/qtmultimedia:5
	dev-qt/qtnetwork:5
	dev-qt/qtopengl:5
	dev-qt/qtprintsupport:5
	dev-qt/qtquickcontrols:5[widgets]
	dev-qt/qtsql:5
	dev-qt/qtwebkit:5
	dev-qt/qtwebsockets:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	media-libs/ladspa-sdk
	media-libs/libsdl:0
	media-libs/libvpx
	>=media-libs/mlt-6.18.0[ffmpeg,frei0r,qt5,sdl,xml,melt]
	media-libs/x264
	media-plugins/frei0r-plugins
	media-sound/lame
	media-video/ffmpeg
	virtual/jack
	"

DEPEND="${RDEPEND}
	dev-qt/qtconcurrent:5
	dev-qt/qtx11extras:5
	"
S="${WORKDIR}"/${P}

src_configure() {
	eqmake5 PREFIX="${EPREFIX}/usr" SHOTCUT_VERSION=${PV}
}

src_install() {
	emake INSTALL_ROOT=${D} install
	einstalldocs
	newicon "${S}"/icons/shotcut-logo-64.png "${PN}".png
	make_desktop_entry shotcut "Shotcut"

	#Install warapper script for melt
	dobin ${FILESDIR}/qmelt
}


pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
}
