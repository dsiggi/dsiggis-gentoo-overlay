# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit eutils python-r1 fdo-mime

DESCRIPTION="A multitrack non-linear video editor"
HOMEPAGE="https://github.com/jliljebl/flowblade"

SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~x86 ~amd64"
S="${WORKDIR}/${P}/${PN}-trunk"

LICENSE="LGPL-3"
SLOT="0"
IUSE=""

DEPEND="
	dev-python/pygtk
	>=x11-libs/gtk+-3.0:3
	dev-python/pygobject:3[cairo]
	media-libs/mlt[python,ffmpeg,gtk]
	dev-python/dbus-python
	media-plugins/frei0r-plugins
	media-plugins/swh-plugins
	dev-python/pycairo
	dev-python/numpy
	dev-python/pillow
	dev-python/librsvg-python
	gnome-base/librsvg:2
	media-gfx/gmic[ffmpeg,X]
	dev-libs/glib:2[dbus]
	x11-libs/gdk-pixbuf:2[X]
	virtual/ffmpeg
	x11-libs/pango
	x11-libs/gdk-pixbuf
	media-libs/fontconfig
	
"
RDEPEND="${DEPEND}"

src_prepare(){
	epatch "${FILESDIR}/${PN}-1.14-install-dir-fix.patch"
	eapply_user

	sed -i "s/env python/env python2/g" "${S}"/flowblade || die
}

src_install(){
	dobin ${PN}
	insinto /usr/share/${PN}
	doins -r Flowblade/*
	doman installdata/${PN}.1
	dodoc README
	doicon -s 128 installdata/io.github.jliljebl.Flowblade.png
	domenu installdata/io.github.jliljebl.Flowblade.desktop
	insinto /usr/share/mime/packages
	doins installdata/io.github.jliljebl.Flowblade.xml
}

pkg_postinst() {
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
}
 
