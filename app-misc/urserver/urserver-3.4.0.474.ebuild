# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="6"

inherit eutils systemd

DESCRIPTION="urserver is the server application for the Unified Remote App on Android, iPhone and Windows Phone."
HOMEPAGE="https://www.unifiedremote.com/"
SRC_URI="https://www.unifiedremote.com/static/builds/server/linux-rpi/${PV##*.}/${P}.tar.gz"

SLOT="0"
LICENSE="urserver"
KEYWORDS="-* arm"

IUSE="systemd"

src_install()
{
dodir /opt/${PN}

cp -r ${WORKDIR}/${P}/* ${D}/opt/${PN}/
rm -f ${D}/opt/${PN}/urserver

exeinto /opt/${PN}
doexe ${WORKDIR}/${P}/urserver

if use systemd; then
	#dodir /etc/systemd/system
	systemd_dounit ${FILESDIR}/urserver.service
else
	dodir /etc/init.d
	newinitd ${FILESDIR}/urserver.initd urserver
fi
}

pkg_postinst()
{
if use systemd; then
	elog "Installed urserver.service"
	elog "Use the command \"systemctl enable urserver.service\""
	elog "to start the daemon at boot time"
else
	elog "Installed urserver-initd-script"
	elog "Use the command \"rc-update add urserver default\""
	elog "to run the daemon at boot time"
fi
}

