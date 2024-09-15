# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit autotools

DESCRIPTION="A command-line software for the isolation, routing and drilling of PCBs."
HOMEPAGE="https://github.com/pcb2gcode/pcb2gcode"
SRC_URI="https://github.com/${PN}/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+geos"

DEPEND="
${RDEPEND}
>=dev-libs/boost-1.60
>=dev-cpp/glibmm-2.4
dev-cpp/gtkmm:2.4
>=sci-electronics/gerbv-2.1
>=gnome-base/librsvg-2
geos? ( <sci-libs/geos-3.12.0 )"

src_prepare() {
	default
	eautoreconf

	# pcb2gcode specifies PKG_CHECK_MODULES calls in its configure.ac file for
	# both glibmm and gdkmm that will not catch newer (but compatible) versions
	# of those libraries, due to the way that glibmm and gtkmm (yes, gtkmm) put
	# forth their pc files.
	# To get around this, because we know we have these libraries installed
	# from the package manager perspective, we cheat: we check for the generic
	# prefix that's registered with pkg-config, and set the corresponding flags.
	# The PKG_CHECK_MODULES macro will see those set, use those values, and
	# consider the libraries present/installed (without doing the direct checks
	# for the values included in the project, which would fail).
	glibmm_MODNAME=`pkg-config --list-package-names | grep glibmm`
	export glibmm_CFLAGS=`pkg-config ${glibmm_MODNAME} --cflags`
	export glibmm_LIBS=`pkg-config ${glibmm_MODNAME} --libs`
	gdkmm_MODNAME=`pkg-config --list-package-names | grep gtkmm`
	export gdkmm_CFLAGS=`pkg-config ${gdkmm_MODNAME} --cflags`
	export gdkmm_LIBS=`pkg-config ${gdkmm_MODNAME} --libs`

	# pcb2gcode need <sci-libs/geos-3.12.0. This break some other packages
	# If useflag "geos" is not set, temove the geos section from configure.ac
	use geos || eapply ${FILESDIR}/disable-geos.patch
}


