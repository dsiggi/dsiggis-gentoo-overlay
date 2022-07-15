# Copyright 1999-2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="7"

inherit eutils xdg-utils desktop

DESCRIPTION="Der Frontplatten Designer ist ein kostenfreies Programm, mit dem Sie mühelos und passgenau die verschiedensten Frontplatten, Gehäuse und Fräßteile entwerfen können"
HOMEPAGE="https://www.schaeffer-ag.de/"
SRC_URI="amd64? ( https://assets.schaeffer-ag.de/fpd/Version-${PV}/FrontDesign-EU-${PV}-amd64.AppImage )
	 x86? ( https://assets.schaeffer-ag.de/fpd/Version-${PV}/FrontDesign-EU-${PV}-i386.AppImage )"
LICENSE="FrontDesigner"
SLOT="0"
KEYWORDS="x86 amd64"


RDEPEND="virtual/glu
	media-libs/libpng"
DEPEND="${RDEPEND}"

src_unpack(){
	cp ${DISTDIR}/${A} ${WORKDIR}/
	cd ${WORKDIR}
	chmod +x ${A}
	./${A} --appimage-extract || die
	mv squashfs-root ${P}
}

src_install() {
	#Install the package to /opt/FrontDesigner
	dodir /opt/${PN}
	cd "${S}/usr"
	cp -R . "${D}/opt/${PN}/" || die "Install failed"

	#Install the binarys
	bins="FrontDesign FrontDesign-Order"
	for b in $bins; do
		chmod +x "${D}"/opt/${PN}/bin/$b
	done

	for f in $(ls ${D}/opt/${PN}/lib/); do
		chmod -x ${D}/opt/${PN}/lib/$f
	done
	
	remove="applications doc pixmaps icons"
	for r in $remove; do
		rm -rf ${D}/opt/${PN}/share/$r
	done

	rm -rf ${D}/opt/${PN}/local

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
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
	xdg_desktop_database_update
}
