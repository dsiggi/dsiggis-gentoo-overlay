# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=(python3_{7,8,9})

inherit eutils distutils-r1

DESCRIPTION="Mopidy extension for editing settings in a webinterface"
HOMEPAGE="https://github.com/woutervanwijk/mopidy-websettings"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="$(python_gen_cond_dep 'media-sound/Mopidy[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/pykka[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/configobj[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep '>=dev-python/jinja-2[${PYTHON_USEDEP}]')"

