# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit qmake-utils desktop xdg-utils

DESCRIPTION="Command-line software for the isolation, routing and drilling of PCBs"
HOMEPAGE="https://github.com/pcb2gcode/pcb2gcode"
SRC_URI="https://github.com/pcb2gcode/pcb2gcodeGUI/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DOCS=( LICENSE README* )

DEPEND="sci-electronics/pcb2gcode
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtsvg:5"
RDEPEND="${DEPEND}"

S=${WORKDIR}/pcb2gcodeGUI-${PV}

src_prepare() {
	default
}

src_configure() {
	eqmake5 PREFIX="${D}"/usr
}

src_install() {
	default
	einstalldocs

	doicon -s 192 ${FILESDIR}/pcb2gcodeGUI.png
	make_desktop_entry pcb2gcodeGUI pcb2gcodeGUI pcb2gcodeGUI Science
}

pkg_postinst() {
        xdg_desktop_database_update
        xdg_icon_cache_update
}

pkg_postrm() {
        xdg_desktop_database_update
        xdg_icon_cache_update
}

