# Copyright 1999-2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="7"

inherit eutils xdg-utils desktop

DESCRIPTION="Der Frontplatten Designer ist ein kostenfreies Programm, mit dem Sie mühelos und passgenau die verschiedensten Frontplatten, Gehäuse und Fräßteile entwerfen können"
HOMEPAGE="https://www.schaeffer-ag.de/"
SRC_URI="amd64? ( https://assets.schaeffer-ag.de/fpd/Version-${PV}/FrontDesign-EU-${PV}-amd64.deb )
	 x86? ( https://assets.schaeffer-ag.de/fpd/Version-${PV}/FrontDesign-EU-${PV}-i386.deb )"
LICENSE="FrontDesigner"
SLOT="0"
KEYWORDS="x86 amd64"


RDEPEND="virtual/glu
	media-libs/libpng"
DEPEND="${RDEPEND}"

S=${PORTAGE_BUILDDIR}/work

src_unpack() {
	unpack ${A}
        cd ${PORTAGE_BUILDDIR}/work
        tar -xpf data.tar.xz
}

src_install() {
	cp -R "${S}/opt" "${D}/"
	
	dodir /usr/
	cp -R "${S}/usr/local" "${D}/usr"

	#Install the iconsq
	doicon -s 48 "${S}"/usr/share/icons/hicolor/48x48/mimetypes/* || die "Failed to install icons"

	#Install a menuentry
	domenu "${S}"/usr/share/applications/* || die "Failed to install menuentrys"

	#Install mime-types
	insinto /usr/share/mime/packages
	doins "${S}"/usr/share/mime/packages/*.xml || die "Failed to install mime-types"

	#Install pixmaps
	insinto /usr/share/pixmaps
	doins "${S}"/usr/share/pixmaps/* || die "Failed to install pixmaps"
}

pkg_postinst() {
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
	xdg_desktop_database_update
}
