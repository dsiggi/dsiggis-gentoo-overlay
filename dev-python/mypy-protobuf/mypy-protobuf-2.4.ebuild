# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_{8,9} )

DISTUTILS_USE_SETUPTOOLS=rdepend
inherit distutils-r1

DESCRIPTION="Generate mypy stub files from protobuf specs"
HOMEPAGE="https://pypi.org/project/mypy-protobuf/ https://github.com/dropbox/mypy-protobuf"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE=""

DEPEND="dev-python/protobuf-python[${PYTHON_USEDEP}]"

LICENSE="Apache-2.0"
SLOT="0"
