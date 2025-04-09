# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..13} )
PYTHON_REQ_USE="tk"
DISTUTILS_SINGLE_IMPL=1
COMMIT="21168969f0b86582f106ccd581e4b61fee3d51c7"

inherit distutils-r1 desktop xdg-utils

DESCRIPTION="Swiss army knife for all your CNC/g-code needs"
HOMEPAGE="https://pypi.org/project/bcnc/ https://github.com/vlachoudis/bCNC"
SRC_URI="https://github.com/vlachoudis/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
IUSE="scipy +serial opencv"

LICENSE="GPLv2"
SLOT="0"

DEPEND="$(python_gen_cond_dep 'dev-python/pyserial[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/numpy[${PYTHON_USEDEP}]')
	scipy? ( $(python_gen_cond_dep 'dev-python/scipy[${PYTHON_USEDEP}]') )
	opencv? ( $(python_gen_cond_dep 'media-libs/opencv[${PYTHON_USEDEP},python]') )
	$(python_gen_cond_dep 'dev-python/pillow[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/svgelements[${PYTHON_USEDEP}]')
	"

S=${WORKDIR}/${PN}-${COMMIT}

python_prepare() {
	rm -rf tests/
}

python_install_all() {
	doicon -s 128 "${FILESDIR}"/${PN}.png
	make_desktop_entry /usr/bin/${PN} ${PN} /usr/share/icons/hicolor/128x128/apps/${PN}.png Utility
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
