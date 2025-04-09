# Copyright 1999-2025 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7
PYTHON_COMPAT=(python3_{9..13})

inherit distutils-r1

DESCRIPTION="Mopidy extension for playing music from TuneIn"
HOMEPAGE="https://github.com/kingosticks/mopidy-tunein"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="$(python_gen_cond_dep 'media-sound/Mopidy[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/pykka[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/requests[${PYTHON_USEDEP}]')"

