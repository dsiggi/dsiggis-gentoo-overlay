# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake flag-o-matic xdg-utils

MY_PN="MellowPlayer"
CMAKE_BUILD_TYPE="Release"

DESCRIPTION="Cloud music integration for your desktop"
HOMEPAGE="https://colinduquesnoy.gitlab.io/MellowPlayer"

SRC_URI="https://gitlab.com/ColinDuquesnoy/${MY_PN}/-/archive/${PV}/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64"

IUSE="+X"

DEPEND="
	X? ( >=media-libs/mesa-20.1.10 )
	>=dev-qt/qtcore-5.15:5
	>=dev-qt/qtquickcontrols2-5.15:5[widgets]
	>=dev-qt/qtquickcontrols-5.15:5[widgets]
	>=dev-qt/qtwebengine-5.15:5[-bindist,widgets]
	>=x11-libs/libnotify-0.7.8
	dev-qt/qtconcurrent
	dev-qt/qtdbus
	dev-qt/qtsql
	dev-qt/qtsvg"

RDEPEND="${DEPEND}"

BDEPEND=">=dev-util/cmake-3.16.5
	 >=sys-devel/gcc-9.3.0-r1"

S="${WORKDIR}/${MY_PN}-${PV}"

pkg_postinst() {

	xdg_desktop_database_update
	xdg_icon_cache_update

	elog
	elog "MellowPlayer is a free, open source and cross-platform desktop application"
	elog "that runs web-based music streaming services in its own window and"
	elog "provides integration with your desktop (hotkeys, multimedia keys, system tray,"
	elog "notifications and more)."
	elog
}

