# Copyright 1999-2025 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7
PYTHON_COMPAT=(python3_{9..13})

inherit distutils-r1

DESCRIPTION="Mopidy extension for playing music from your local music archive"
HOMEPAGE="https://github.com/mopidy/mopidy-local"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="$(python_gen_cond_dep 'media-sound/Mopidy[${PYTHON_USEDEP}]')"

