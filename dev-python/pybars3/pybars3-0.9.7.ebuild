# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="Handlebars.js templating for Python 3 and 2"
HOMEPAGE="https://github.com/wbond/pybars3"
SRC_URI="$(pypi_sdist_url "${PN^}" "${PV^}")"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-python/PyMeta3-0.5.1"

LICENSE="MIT"
SLOT="0"
