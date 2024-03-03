# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake kodi-addon

DESCRIPTION="Tvheadend Live TV and Radio PVR client addon for Kodi"
HOMEPAGE="https://github.com/kodi-pvr/pvr.hts"
SRC_URI=""

CODENAME="Nexus"
KEYWORDS="~amd64 ~x86"
SRC_URI="https://github.com/kodi-pvr/pvr.hts/archive/${PV}-${CODENAME}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pvr.hts-${PV}-${CODENAME}"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="
	~media-tv/kodi-$(ver_cut 1).$(ver_cut 2)
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
