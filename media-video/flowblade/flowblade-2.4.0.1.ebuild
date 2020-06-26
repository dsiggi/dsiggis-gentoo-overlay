# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=( python3_{6,7} )
inherit eutils python-r1 fdo-mime

PKG_POST_NAME="-fix_release"

DESCRIPTION="A multitrack non-linear video editor"
HOMEPAGE="https://github.com/jliljebl/flowblade"

SRC_URI="${HOMEPAGE}/archive/v${PV}${PKG_POST_NAME}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~x86 ~amd64"
S="${WORKDIR}/${P}/${PN}-trunk"

LICENSE="LGPL-3"
SLOT="0"
IUSE=""

DEPEND="
	>=x11-libs/gtk+-3.0:3
	$(python_gen_cond_dep 'dev-python/pygobject:3[cairo,${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'media-libs/mlt[python,ffmpeg,gtk,${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/dbus-python[${PYTHON_USEDEP}]')
	media-plugins/frei0r-plugins
	media-plugins/swh-plugins
	$(python_gen_cond_dep 'dev-python/numpy[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/pillow[${PYTHON_USEDEP}]')
	gnome-base/librsvg:2
	media-gfx/gmic[ffmpeg,X]
	dev-libs/glib:2[dbus]
	x11-libs/gdk-pixbuf:2[X]
	virtual/ffmpeg
	x11-libs/pango
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
 
