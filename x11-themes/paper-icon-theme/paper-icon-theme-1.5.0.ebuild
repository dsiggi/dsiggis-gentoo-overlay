# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit gnome2 meson

DESCRIPTION="A simple and modern icon theme with material design influences"
HOMEPAGE="https://snwh.org/paper"
SRC_URI="https://github.com/snwh/${PN}/archive/v.${PV}.tar.gz"

LICENSE="CC-BY-SA-4.0"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="
	${DEPEND}
"
S="${WORKDIR}/${PN}-v.${PV}/"

src_prepare() {
	gnome2_src_prepare
	find Paper* -type f -perm /111 -execdir chmod 0644 {} +
}
