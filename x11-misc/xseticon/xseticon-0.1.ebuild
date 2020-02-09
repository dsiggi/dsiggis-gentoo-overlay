# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Set the X11 window icon for any given window to that of a given image file"
HOMEPAGE="http://leonerd.org.uk/code/xseticon"
SRC_URI="http://www.leonerd.org.uk/code/${PN}/${P}+bzr14.tar.gz -> ${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RDEPEND="media-libs/gd"
DEPEND="${RDEPEND}
	x11-libs/libX11"

S="${WORKDIR}/${P}+bzr14"

src_compile() {
	emake || die
}

src_install() {
	dobin ${S}/${PN}
}
