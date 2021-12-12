# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake kodi-addon #eapi7-ver

DESCRIPTION="Tvheadend Live TV and Radio PVR client addon for Kodi"
HOMEPAGE="https://github.com/kodi-pvr/pvr.hts"
SRC_URI=""

CODENAME="Matrix"
KEYWORDS="~amd64 ~x86"
MY_PV=$(ver_cut 1).0.$(ver_cut 2)
SRC_URI="https://github.com/kodi-pvr/pvr.hts/archive/${MY_PV}-${CODENAME}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pvr.hts-${MY_PV}-${CODENAME}"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="
	~media-tv/kodi-${PV}
	"

RDEPEND="
	${DEPEND}
	"

