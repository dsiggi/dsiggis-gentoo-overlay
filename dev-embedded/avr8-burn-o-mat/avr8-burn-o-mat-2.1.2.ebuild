# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg-utils desktop

DESCRIPTION="GUI for avrdude Atmel programmer tool"
HOMEPAGE="http://burn-o-mat.net"
SRC_URI="http://burn-o-mat.net/AVR8_Burn-O-Mat_2_1_2.zip -> ${P}.zip"

LICENSE="GPL3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-embedded/avrdude
	virtual/jre"

DEPEND="${RDEPEND}"

S=${WORKDIR}/AVR8_Burn-O-Mat

src_prepare() {
	eapply_user
}

src_install() {
	dobin ${FILESDIR}/${PN}

	insinto /usr/share/${PN}
	doins ${S}/AVR8_Burn_O_Mat.jar
	doins ${S}/AVR8_Burn_O_Mat_Config.xml
	doins ${S}/AVR8_Burn-O-Mat.png
	doins ${S}/AVR8_Burn-O-Mat_Icon_16.png

	insinto /usr/share/${PN}/lib
	doins ${S}/lib/*.jar

	newicon -s 16 ${S}/AVR8_Burn-O-Mat_Icon_16.png ${PN}.png
	make_desktop_entry /usr/bin/${PN} ${PN} /usr/share/icons/hicolor/16x16/apps/${PN}.png Development
}


pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
