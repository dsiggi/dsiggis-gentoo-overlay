# Copyright 1999-2025 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7
PYTHON_COMPAT=(python3_{9..13})

inherit distutils-r1

DESCRIPTION="An extensible music server that plays music from local disk and more"
HOMEPAGE="http://mopidy.com https://github.com/mopidy/mopidy"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="$(python_gen_cond_dep 'dev-python/pykka[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep '>=dev-python/gst-python-1.2.3:1.0[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/pygobject[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/requests[${PYTHON_USEDEP}]')
	>=media-libs/gst-plugins-ugly-1.2.3:1.0
	>=media-plugins/gst-plugins-soup-1.2.3:1.0
	>=media-plugins/gst-plugins-flac-1.2.3:1.0
	>=media-plugins/gst-plugins-mpg123-1.2.3:1.0
	$(python_gen_cond_dep 'www-servers/tornado[${PYTHON_USEDEP}]')"

