# Copyright 1999-2025 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7
PYTHON_COMPAT=(python3_{10..13})
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="URI parsing, classification and composition"
HOMEPAGE="https://github.com/tkem/uritools/"
SRC_URI="$(pypi_sdist_url "${PN^}" "${PV^}")"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE=""

