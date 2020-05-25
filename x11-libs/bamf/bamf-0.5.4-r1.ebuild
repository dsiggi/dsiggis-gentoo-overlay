# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

VALA_MIN_API_VERSION=0.20
VALA_USE_DEPEND=vapigen

inherit vala autotools

DESCRIPTION="BAMF Application Matching Framework"
HOMEPAGE="https://launchpad.net/bamf"
SRC_URI="http://launchpad.net/${PN}/0.5/${PV}/+download/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+introspection doc static-libs"

RDEPEND="
	dev-libs/dbus-glib
	dev-util/gdbus-codegen
	dev-libs/glib:2
	gnome-base/libgtop:2
	x11-libs/gtk+:3
	x11-libs/libX11
	>=x11-libs/libwnck-3.4.7:3"
DEPEND="${RDEPEND}
	$(vala_depend)
	doc? ( dev-util/gtk-doc )
	introspection? ( dev-libs/gobject-introspection )
	virtual/pkgconfig"

DOCS=(AUTHORS COPYING COPYING.LGPL ChangeLog NEWS README TODO)

src_prepare() {
	epatch ${FILESDIR}/bamf-no-gtester2xunit.patch

	sed -i 's/-Werror//' configure.ac

	#Bestimme vapigen-version zum patchen
	vapigen_bin=$(ls /usr/bin/vapigen*)
	vapigen_bin=${vapigen_bin##*vapigen}

	sed -i "s/vapigen/vapigen${vapigen_bin}/g" configure.ac

	eapply_user

	eautoreconf
	vala_src_prepare
}

src_configure() {
	local myeconfargs=(
		--disable-gtktest
		$(use_enable doc gtk-doc)
		$(use_enable introspection)
		VALA_API_GEN="${VAPIGEN}"
	)
	econf ${myeconfargs}
}

