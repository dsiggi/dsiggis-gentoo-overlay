# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_{9,10} )

inherit distutils-r1

DESCRIPTION="Create Beautiful Tkinter GUIs by Drag and Drop "
HOMEPAGE="https://github.com/ParthJadhav/Tkinter-Designer"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
IUSE=""

LICENSE="BSD3-Clause"
SLOT="0"

RDEPEND="$(python_gen_cond_dep 'dev-python/certifi[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/chardet[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/idna[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/markupsafe[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/requests[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/urrlib3[${PYTHON_USEDEP}]')"

