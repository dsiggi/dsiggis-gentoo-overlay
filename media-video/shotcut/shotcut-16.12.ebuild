# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: 

EAPI=6

inherit eutils qmake-utils

DESCRIPTION="A free, open source, cross-platform video editor"
HOMEPAGE="http://www.shotcut.org/"
SRC_URI="https://github.com/mltframework/shotcut/releases/download/v${PV}/${PN}-src-161203.tar.bz2 -> ${P}.tar.bz2
	https://github.com/mltframework/shotcut/releases/download/v${PV}/${PN}-linux-x86_64-161203.tar.bz2 -> shotcut-translations.tar.bz2"

LICENSE="GPL-3"

SLOT="0"

KEYWORDS="~x86 ~amd64"

IUSE=""

DEPEND="
	media-libs/mlt[qt5,ffmpeg,frei0r,python,melt]
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtx11extras:5
	dev-qt/qtsql:5
	dev-qt/qtwebkit:5
	dev-qt/qtquickcontrols:5
	dev-qt/qtnetwork:5
	dev-qt/qtxml:5
	dev-qt/qtopengl:5
	dev-qt/qtwidgets:5
	dev-qt/qtconcurrent:5
	dev-qt/qtmultimedia:5
	dev-qt/qtprintsupport:5
	dev-qt/qtwebsockets:5
	dev-qt/qtgraphicaleffects:5
	=media-video/ffmpeg-2*
	media-libs/x264
	media-libs/libvpx
	media-sound/lame
	>=media-plugins/frei0r-plugins-1.5.0
	media-libs/ladspa-sdk
	"

RDEPEND="${DEPEND}
	virtual/jack"

S="${WORKDIR}"/src

src_compile() {
	cd ${S}/shotcut
	eqmake5 -r PREFIX="${D}/usr/"
	emake || die
}

src_install() {
	cd ${S}/shotcut
	emake PREFIX=/usr DESTDIR="${D}" install
	newicon "${S}"/shotcut/icons/shotcut-logo-64.png "${PN}".png
	make_desktop_entry shotcut "Shotcut"

	#Copy Translations
	insinto /usr/share/shotcut
	doins -r ${WORKDIR}/Shotcut/Shotcut.app/share/shotcut/translations

	#Install warapper script for melt
	dobin ${FILESDIR}/qmelt
}

