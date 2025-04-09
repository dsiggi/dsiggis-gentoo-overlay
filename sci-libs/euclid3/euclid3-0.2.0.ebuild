# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="vector, matrix, quaternion and some geometry in 2D and 3D for Python 3"
HOMEPAGE="https://github.com/euclid3/euclid3/"
SRC_URI="https://github.com/euclid3/euclid3/archive/refs/tags/v$PV.tar.gz -> $P.tar.gz"
DISTUTILS_USE_PEP517=setuptools

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64"
