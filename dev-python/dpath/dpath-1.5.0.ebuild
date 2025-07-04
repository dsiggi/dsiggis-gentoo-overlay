# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Filesystem-like pathing and searching for dictionaries"
HOMEPAGE="https://www.github.com/akesterson/dpath-python"
SRC_URI="https://github.com/akesterson/dpath-python/archive/build,1.5,0.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S=${WORKDIR}/${PN}-python-build-1.5-0
