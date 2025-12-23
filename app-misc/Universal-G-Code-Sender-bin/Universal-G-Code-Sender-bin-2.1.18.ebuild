# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg-utils desktop

MY_PN=${PN%-bin}

DESCRIPTION="A cross-platform G-Code sender for GRBL, Smoothieware, TinyG and G2core."
HOMEPAGE="https://universalgcodesender.com/"
SRC_URI="amd64? ( https://github.com/winder/${MY_PN}/releases/download/v${PV}/linux-x64-ugs-platform-app-${PV}.tar.gz -> ${PN}-amd64-${PV}.tar.gz )
			arm? ( https://github.com/winder/${MY_PN}/releases/download/v${PV}/linux-arm-ugs-platform-app-${PV}.tar.gz -> ${PN}-arm-${PV}.tar.gz )
			arm64? ( https://github.com/winder/${MY_PN}/releases/download/v${PV}/linux-aarch64-ugs-platform-app-${PV}.tar.gz -> ${PN}-arm64-${PV}.tar.gz )
"
KEYWORDS="-* ~amd64 ~arm ~arm64"
IUSE=""

LICENSE="GPLv3"
SLOT="0"
QA_PREBUILT="opt/*"

src_unpack() {
	if use amd64; then
		UGS_ARCH=x64
	elif use arm; then
		UGS_ARCH=arm
	elif use arm64; then
		UGS_ARCH=aarch64
	fi

	S=${WORKDIR}/ugsplatform-linux-${UGS_ARCH}

	default
}

src_install() {
	cd ${S}
	dodir /opt/${PN}

	cp -aR * ${D}/opt/${PN}/

	dosym /opt/Universal-G-Code-Sender-bin/bin/ugsplatform /usr/bin/ugsplatform

	newicon -s scalable ${S}/bin/icon.svg ugsplatform.svg
	make_desktop_entry "/usr/bin/ugsplatform %U" Universal-G-Code-Sender ugsplatform Utility
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
