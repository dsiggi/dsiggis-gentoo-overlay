# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=8
inherit systemd udev

DESCRIPTION="Linux driver for the Xbox One wireless dongle"
HOMEPAGE="https://medusalix.github.io/xow/"
SRC_URI="https://github.com/medusalix/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	http://download.windowsupdate.com/c/msdownload/update/driver/drvs/2017/07/1cd6a87c-623f-4407-a52d-c31be49e925c_e19f60808bdcbfbd3c3df6be3e71ffc52e43261e.cab -> xow-firmware.cab"

SLOT="0"
LICENSE="GPL-2 Microsoft"
KEYWORDS="~x86 ~amd64"

IUSE="systemd openrc -debug"
QA_EXECSTACK="usr/bin/xow"

BDEPEND="app-arch/cabextract"

src_unpack()
{
	unpack ${P}.tar.gz
	cp ${DISTDIR}/xow-firmware.cab ${S}/driver.cab
}

src_prepare()
{
	#Entferne den Firmwaredownload aus dem Makefile
	sed -i '/curl/d' ${S}/Makefile || die

	eapply_user
}


src_compile()
{	if use debug; then
		emake BUILD=DEBUG
	else
		emake BUILD=RELEASE
	fi
}

src_install()
{
	dobin xow
	
	if use systemd; then
		systemd_dounit ${FILESDIR}/xow.service
		udev_dorules ${FILESDIR}/xow.rules
		udev_reload
	fi

	if use openrc; then
		doinitd ${FILESDIR}/xow
	fi
}
