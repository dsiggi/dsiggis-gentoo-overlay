# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils xdg desktop

DESCRIPTION="Your computer in the cloud"
HOMEPAGE="https://paperspace.com"

LICENSE=""
SLOT="0"

SRC_URI=""
S="${WORKDIR}"
KEYWORDS="~amd64"

QA_PREBUILT="opt/paperspace/maintenancetool \
		/opt/paperspace/lib/libQt5WebEngineCore.so.5 \
		/opt/paperspace/lib/libicuuc.so.60 \
		/opt/paperspace/lib/libicui18n.so.60 \
		/opt/paperspace/lib/libicudata.so.60 \
		/opt/paperspace/lib/libwebp.so.5 \
		/opt/paperspace/lib/libevent-2.0.so.5 \
		/opt/paperspace/lib/libwebpmux.so.1 \
		/opt/paperspace/lib/libwebpdemux.so.1 \
		/opt/paperspace/lib/libsnappy.so.1"

src_install() {
	if [ ! -d /tmp/${P} ]; then
		einfo "This package has an qt isntaller."
		einfo "It's not possible to extract it with portage."
		einfo "Please run the extract.sh script from the FILESDIR."
		einfo "This script will download, extract an recompress the setup to /tmp"
		einfo "After this copy the ${P}.tar.gz to DISTDIR."
	fi
	
	elog "Installing /tmp/${P} to system"
	dodir /opt/paperspace
	cp -R /tmp/${P}/. ${D}/opt/paperspace/ || die "Install failed!"
	mv ${D}/opt/paperspace/linux-icon-310x310.png ${D}/opt/paperspace/paperspace.png
	
	doicon ${D}/opt/paperspace/paperspace.png
	#make_desktop_entry /opt/paperspace/paperspace.sh Paperspace /usr/share/pixmaps/paperspace.png Application
	domenu ${FILESDIR}/paperspace.desktop
}

pkg_preinst() {
	xdg_pkg_preinst
	gnome2_schemas_savelist
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
	optfeature "gamemode support" games-util/gamemode
}

