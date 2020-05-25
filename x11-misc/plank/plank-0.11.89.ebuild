# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

VALA_MIN_API_VERSION=0.26
VALA_USE_DEPEND=vapigen

inherit vala autotools xdg-utils

DESCRIPTION="Dock panel famious docky"
HOMEPAGE="https://launchpad.net/plank"
SRC_URI="http://launchpad.net/${PN}/1.0/${PV}/+download/${P}.tar.xz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+introspection doc static-libs"
RESTRICT="mirror"
RDEPEND=">=dev-libs/glib-2.32:2
	dev-libs/libgee:0.8
	x11-libs/gtk+:3
	x11-libs/bamf
	x11-libs/libX11
	dev-libs/libdbusmenu
	x11-libs/libwnck:3
	>=x11-libs/cairo-1.13"
DEPEND="${RDEPEND}
	$(vala_depend)
	dev-util/intltool
	gnome-base/gnome-common
	sys-devel/gettext
	virtual/pkgconfig"
DOCS=( AUTHORS COPYRIGHT )

src_prepare() {
	eapply_user

	NOCONFIGURE=1 REQUIRED_PKG_CONFIG_VERSION=0.1 eautoreconf
	vala_src_prepare
}

pkg_postinst()
{
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm()
{
	xdg_desktop_database_update
	xdg_icon_cache_update
}
