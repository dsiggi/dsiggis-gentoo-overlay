# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils xdg-utils

MY_PN=${PN%*-bin}
MY_P=${MY_PN}-${PV}

DESCRIPTION="A Native GUI Epic Games Launcher for Linux, Windows and Mac. "
HOMEPAGE="https://github.com/Heroic-Games-Launcher/HeroicGamesLauncher"
SRC_URI="https://github.com/Heroic-Games-Launcher/${MY_PN}/releases/download/v${PV}/heroic-${PV}.tar.xz -> ${MY_P}.tar.xz"
KEYWORDS="~amd64 ~x86"
IUSE=""

LICENSE="GPLv3"
SLOT="0"

RDEPEND="sys-apps/gawk
	sys-fs/fuse"	

S=${WORKDIR}/heroic-${PV}

src_compile() {
	# Nichts zu tun
	echo ""
}

src_install() {
	insinto /opt/${MY_PN}
	doins -r ${S}/*

	chmod +x ${D}/opt/${MY_PN}/heroic
	chmod +x ${D}/opt/${MY_PN}/resources/app.asar.unpacked/build/bin/linux/legendary

	exeinto /usr/bin/
	doexe ${FILESDIR}/heroic

	newicon -s 512 ${S}/resources/app.asar.unpacked/build/icon.png ${MY_PN}.png
	make_desktop_entry /usr/bin/heroic ${MY_PN} /usr/share/icons/hicolor/512x512/apps/${MY_PN}.png Game
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
