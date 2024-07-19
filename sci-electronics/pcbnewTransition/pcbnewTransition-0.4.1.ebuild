
# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{11..12} )
DISTUTILS_USE_PEP517="setuptools"
DISTUTILS_SINGLE_IMPL=1
inherit distutils-r1 pypi

DESCRIPTION="Library that allows you to support both, KiCAD 5 and KiCAD 6 in your plugins"
HOMEPAGE="https://github.com/yaqwsx/pcbnewTransition"
SRC_URI="$(pypi_sdist_url --no-normalize "${PN}" "${PV}")
         https://raw.githubusercontent.com/yaqwsx/pcbnewTransition/main/versioneer.py"
KEYWORDS="~amd64 ~x86"
IUSE=""

LICENSE="MIT"
SLOT="0"

S=${WORKDIR}/${P}

python_prepare_all() {
    cp ${DISTDIR}/versioneer.py ${S}/versioneer.py || die
    distutils-r1_python_prepare_all
}
