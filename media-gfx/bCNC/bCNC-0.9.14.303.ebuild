# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_6)

inherit distutils-r1

DESCRIPTION="Swiss army knife for all your CNC/g-code needs"
HOMEPAGE="https://pypi.org/project/bcnc/ https://github.com/vlachoudis/bCNC"
SRC_URI="https://files.pythonhosted.org/packages/35/42/97c268e4129f3b0e79097806b5fbd899e60a450c52cc881ee7e9d4aead02/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
IUSE="scipy +serial opencv"

LICENSE="GPLv2"
SLOT="0"

RDEPEND="dev-lang/python[tk]"
DEPEND="serial? ( dev-python/pyserial[${PYTHON_USEDEP}] )
	dev-python/numpy[${PYTHON_USEDEP}]
	scipy? ( sci-libs/scipy[${PYTHON_USEDEP}] )
	opencv? ( media-libs/opencv[${PYTHON_USEDEP},python] )
	dev-python/pillow[${PYTHON_USEDEP}]"

python_prepare() {
	sed -i -e "s/find_packages()/find_packages(exclude=['tests'])/" setup.py || die
}


