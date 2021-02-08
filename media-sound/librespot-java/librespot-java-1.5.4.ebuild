# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils systemd

DESCRIPTION="A Spotify Connect enabled headless client"
HOMEPAGE="https://github.com/librespot-org/librespot-java"
SRC_URI="https://github.com/librespot-org/${PN}/releases/download/v${PV}/librespot-player-${PV}.jar"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE="systemd"

LICENSE="APACHE"
SLOT="0"

DEPEND="virtual/jre"

S=${WORKINGDIR}/..

src_unpack() {
	#Nichts zu tun hier
	true
}

src_compile() {
	#Nichts zu tun hier
	true
}

src_install() {
	dodir /opt/${PN}
	cp ${DISTDIR}/librespot-player-${PV}.jar ${D}/opt/${PN} || die

	insinto /etc/${PN}
	doins ${FILESDIR}/config.toml

	if use systemd; then
		systemd_dounit ${FILESDIR}/${PN}.service
	fi
}

