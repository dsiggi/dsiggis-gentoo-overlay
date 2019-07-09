# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit gnome2 meson

DESCRIPTION="A stylized icon set designed to be clear, simple and consistent"
HOMEPAGE="https://snwh.org/moka"
SRC_URI="https://github.com/snwh/${PN}/archive/v${PV}.tar.gz"

LICENSE="CC-BY-SA-4.0"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="
	${DEPEND}
"
