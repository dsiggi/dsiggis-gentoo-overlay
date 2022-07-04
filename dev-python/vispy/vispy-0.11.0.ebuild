# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{9,10} )

inherit distutils-r1

DESCRIPTION="Interactive visualization in Python"
HOMEPAGE="https://pypi.org/project/vispy/ https://vispy.org"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE=""

DEPEND="dev-python/wheel[${PYTHON_USEDEP}]
	dev-python/setuptools_scm_git_archive[${PYTHON_USEDEP}]"
RDEPEND="dev-python/PyQt5[${PYTHON_USEDEP},testlib]"

LICENSE="BSD"
SLOT="0"
