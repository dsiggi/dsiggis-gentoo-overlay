# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=(python3_{7,8,9})

inherit eutils distutils-r1

DESCRIPTION="A Mopidy Web client based on the (old) Spotify interface. Improved to work with spotify as main library."
HOMEPAGE="https://github.com/dirkgroenen/Mopify"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="$(python_gen_cond_dep 'media-sound/Mopidy[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/configobj[${PYTHON_USEDEP}]')"

