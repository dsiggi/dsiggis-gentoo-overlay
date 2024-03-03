# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake kodi-addon

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

src_prepare()
{
	eapply_user
	cmake_src_prepare

	linenumber=$(grep -n "#include <string>" ${S}/src/tvheadend/HTSPVFS.h | cut -d":" -f1) || die
	sed -i "${linenumber}i #include <cstdint>" ${S}/src/tvheadend/HTSPVFS.h || die
}
