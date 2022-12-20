# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

DESCRIPTION="DVBlast is a simple and powerful MPEG-2/TS demux and streaming
application with several input methods."
HOMEPAGE="http://www.videolan.org/projects/dvblast.html"
SRC_URI="https://get.videolan.org/dvblast/${PV}/${P}.tar.bz2"


IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"


RDEPEND="media-libs/bitstream"
DEPEND="dev-libs/libev
	${RDEPEND}"
