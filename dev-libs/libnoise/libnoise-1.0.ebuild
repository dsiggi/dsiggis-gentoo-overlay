# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Distribution of noise library only meant for interfacing noise with OrcaSlicer"
HOMEPAGE="https://github.com/SoftFever/Orca-deps-libnoise"
SRC_URI="
	https://github.com/SoftFever/Orca-deps-libnoise/archive/refs/tags/${PV}.tar.gz
"

LICENSE="LGPL2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
DEPEND=""
RDEPEND="
	${DEPEND}
"
BDEPEND="
	virtual/pkgconfig
"
S="${WORKDIR}/Orca-deps-${P}"
