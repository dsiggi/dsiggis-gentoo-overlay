# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

EAPI=5
inherit fdo-mime autotools eutils versionator gnome2-utils

DESCRIPTION="A GTK+ interface to MPV"
HOMEPAGE="https://github.com/gnome-mpv/gnome-mpv/"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEPEND=">=dev-libs/glib-2.30
	>=x11-libs/gtk+-3.18:3
	x11-libs/libX11"
RDEPEND="${COMMON_DEPEND}
	x11-themes/gnome-icon-theme-symbolic
	>=media-video/mpv-0.20.0[libmpv]"
DEPEND="${COMMON_DEPEND}
	dev-libs/appstream-glib
	sys-devel/gettext
	virtual/pkgconfig"

DOCS="README.md"

src_prepare() {
	sed -i '/$(UPDATE_DESKTOP)/d' Makefile.am || die
	sed -i '/$(UPDATE_ICON)/d' Makefile.am || die
	sed -i '/install-data-hook:/d' Makefile.am || die
	sed -i '/uninstall-hook:/d' Makefile.am || die
	mkdir m4
	eautoreconf
}

pkg_preinst() {
	gnome2_icon_savelist
	gnome2_schemas_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
	gnome2_schemas_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
	gnome2_schemas_update
}
