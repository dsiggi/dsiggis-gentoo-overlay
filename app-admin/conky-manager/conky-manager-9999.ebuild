# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="6"

inherit eutils bzr

DESCRIPTION="conky-manager is a configuration gui for conky."
HOMEPAGE="http://teejeetech.blogspot.in/p/conky-manager.html"
EBZR_REPO_URI="lp:conky-manager"


LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="x86 amd64"


RDEPEND="app-admin/conky
		 x11-libs/gtk+:3
		 =dev-lang/vala-0.30.1
		 dev-libs/libgee:0.8"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${P}"

bzr_src_prepare() {
	sed -i "s/valac/valac-0.30/g" "${S}"/src/makefile
	eapply_user
}

src_compile() {
	emake || die "Fehler"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	rm -f "${D}"/usr/bin/conky-manager-uninstall
}
