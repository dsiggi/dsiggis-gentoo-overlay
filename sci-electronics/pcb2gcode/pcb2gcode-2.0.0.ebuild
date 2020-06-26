# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
GUI_V=1.3.2-1

inherit autotools eutils fdo-mime qmake-utils

DESCRIPTION="Command-line tool for isolation, routing and drilling of PCBs"
HOMEPAGE="https://github.com/pcb2gcode/pcb2gcode"
IUSE="gui"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	gui? ( https://github.com/${PN}/${PN}GUI/archive/v${GUI_V}.tar.gz )"
KEYWORDS="~amd64 ~x86"

LICENSE="GPLv3"
SLOT="0"

DEPEND="dev-libs/boost
	dev-cpp/gtkmm:2.4
	>=sci-electronics/gerbv-2.1.0
	gui? ( dev-qt/qtsvg
		dev-qt/qtcore )"

MY_S=${S}
GUI_S=${WORKDIR}/pcb2gcodeGUI-${GUI_V}

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	default
}

src_compile() {
	elog "Building CLI"
	default

	if use gui; then
		elog "Building GUI"
		cd ${GUI_S}
		eqmake5 PREFIX="${D}/usr"
		emake
	fi
}

src_install() {
	elog "Installing CLI"
	default

	if use gui; then
		elog "Installing GUI"
		cd ${GUI_S}
		emake DESTDIR="${D}" install
	fi
}

#pkg_postinst() {
#	fdo-mime_mime_database_update
#	xdg_desktop_database_update
#	xdg_icon_cache_update
#}

#pkg_postrm() {
#	fdo-mime_mime_database_update
#	xdg_desktop_database_update
#	xdg_icon_cache_update
#}
