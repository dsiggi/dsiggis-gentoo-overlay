# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1

inherit distutils-r1 pypi

DESCRIPTION="Interactive visualization in Python"
HOMEPAGE="https://pypi.org/project/vispy/ https://vispy.org"
SRC_URI="$(pypi_sdist_url "${PN^}" "${PV}")"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE=""

DEPEND="dev-python/wheel[${PYTHON_USEDEP}]"
RDEPEND="dev-python/PyQt5[${PYTHON_USEDEP},testlib]"

LICENSE="BSD"
SLOT="0"

src_prepare() {
	default
	eapply ${FILESDIR}/setuptools_scm_git_archive.patch
}
