# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="OpenSCAD for Python"
HOMEPAGE="https://github.com/jeff-dh/SolidPython/"
SRC_URI="https://github.com/jeff-dh/SolidPython/archive/refs/tags/v$PV.tar.gz -> $P.tar.gz"
S=$WORKDIR/SolidPython-$PV

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="( 
	   >=sci-libs/euclid3-0.1.0
	   >=dev-python/pypng-0.0.19
	   dev-python/prettytable
	   >=dev-python/ply-3.11
         )"
