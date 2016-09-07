# Copyright 2016 Jan Chren (rindeal)
# Distributed under the terms of the GNU General Public License v2

EAPI=6

GH_URI='github/kokoko3k'
GH_REF="${PV}"

inherit eutils

DESCRIPTION="Xt7-Player-mpv is a graphical interface to mpv, focused on usability"
HOMEPAGE="http://xt7-player.sourceforge.net/xt7forum/"
LICENSE="GPL-3"

SRC_URI="https://github.com/kokoko3k/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"

KEYWORDS="~amd64"
IUSE="taglib global-hotkeys dvb youtube" # FIXME

DEPEND="
	dev-lang/gambas:3[libxml,qt4,dbus,x11,net,curl]
	dev-qt/qtcore:4
	media-video/mpv:0
"
RDEPEND="${DEPEND}"

src_compile() {
	local gbc_args=(
		# --verbose # this is extremely verbose
		--translate-errors
		--all
		--translate # l10n
		--public-control
		--public-module
	)
	gbc3 "${gbc_args[@]}" . || die
	gba3 || die
}

src_install() {
	newbin ${PN}*.gambas "$PN"

	sed "s|${PN}.*\.gambas|${PN}|" \
        -i -- "${PN}.desktop" || die
	domenu "${PN}.desktop"

	doicon -s 48 "${PN}.png"
}
