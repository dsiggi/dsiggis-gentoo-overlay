# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{10..12} )
inherit distutils-r1

DESCRIPTION="Persistent, stale-free, local and cross-machine caching for Python functions"
HOMEPAGE="https://github.com/shaypal5/cachier"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="$(python_gen_cond_dep 'dev-python/watchdog[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/portalocker[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/pathtools[${PYTHON_USEDEP}]')"
