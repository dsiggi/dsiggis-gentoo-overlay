# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{8..12} )

inherit distutils-r1

GIT_COMMIT=c814c100de31525b750b533765e460c3ad456185

DESCRIPTION="legacy SolidPython utils ported to SolidPython 2"
HOMEPAGE="https://github.com/jeff-dh/solidpython2_legacy/"
SRC_URI="https://github.com/jeff-dh/solidpython2_legacy/archive/$GIT_COMMIT.tar.gz -> $P.tar.gz"
S=$WORKDIR/solidpython2_legacy-$GIT_COMMIT

PATCHES="$FILESDIR/$P-euclid3.patch"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="( 
	   sci-libs/solidpython2
         )"
