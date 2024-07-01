# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11,12} )

inherit distutils-r1 cmake

DESCRIPTION="Linear optimization software"
HOMEPAGE="https://github.com/ERGO-Code/HiGHS"
SRC_URI="https://github.com/ERGO-Code/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S=$WORKDIR/HiGHS-$PV

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_configure() {

    local mycmakeargs=(
            -DBUILD_CXX=ON \
            -DFORTRAN=ON \
            -DCSHARP=ON \
	    -DZLIB=OFF    )

    cmake_src_configure
}
