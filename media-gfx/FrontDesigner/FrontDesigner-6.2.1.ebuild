# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="6"

inherit eutils fdo-mime xdg-utils

DESCRIPTION="Der Frontplatten Designer ist ein kostenfreies Programm, mit dem Sie mühelos und passgenau die verschiedensten Frontplatten, Gehäuse und Fräßteile entwerfen können"
HOMEPAGE="https://www.schaeffer-ag.de/"
SRC_URI="amd64? ( https://assets.schaeffer-ag.de/fpd/Version-${PV}/FrontDesign-EU-${PV}-amd64.tgz )
	 x86? ( https://assets.schaeffer-ag.de/fpd/Version-${PV}/FrontDesign-EU-${PV}-i386.tgz )"
LICENSE="FrontDesigner"
SLOT="0"
KEYWORDS="x86 amd64"


RDEPEND="virtual/glu
	media-libs/libpng"
DEPEND="${RDEPEND}"

S="${WORKDIR}/FrontDesign"

src_unpack(){
		unpack ${A}
}

src_install() {
	#Install the package to /opt/FrontDesigner
	dodir /opt/${PN}
	cd "${S}"
	cp -R . "${D}/opt/${PN}/" || die "Install failed"

	#Install the binarys
	bins="FrontDesign FrontDesign-Order"
	exeinto /opt/${PN}/bin
	for b in $bins; do
		rm -f "${D}"/opt/${PN}/$b
		doexe "${S}"/bin/$b
	done

	#Install the icons
	doicon -s 48 "${FILESDIR}"/icons/* || die "Failed to install icons"

	#Install a menuentry
	domenu "${FILESDIR}"/*.desktop || die "Failed to install menuentrys"

	#Install mime-types
	insinto /usr/share/mime/packages
	doins "${FILESDIR}"/mime/*.xml || die "Failed to install mime-types"

	#Install pixmaps
	insinto /usr/share/pixmaps
	doins "${FILESDIR}"/pixmaps/*.png || die "Failed to install pixmaps"
}

pkg_postinst() {
	fdo-mime_mime_database_update
	xdg_desktop_database_update
}

pkg_postrm() {
	fdo-mime_mime_database_update
	xdg_desktop_database_update
}
