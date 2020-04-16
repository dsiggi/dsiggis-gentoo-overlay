# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_{6,7} )
DISTUTILS_USE_SETUPTOOLS=bdepend

inherit distutils-r1 eutils fdo-mime #python-r1

DESCRIPTION="2D drawings to CNC machine compatible G-Code converter"
HOMEPAGE="https://sourceforge.net/projects/dxf2gcode/"
SRC_URI="mirror://sourceforge/${PN}/${P}.zip"
KEYWORDS="~amd64 ~x86"

LICENSE="GPLv3"
SLOT="0"

RDEPEND="$(python_gen_cond_dep '>=dev-python/PyQt5-5.7[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep '>=dev-python/PyQt5-5.7[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep '>=dev-python/pyopengl-3.1[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep '>=dev-python/configobj-5.0.6[${PYTHON_USEDEP}]')
	>=app-text/poppler-0.45
	>=media-gfx/pstoedit-3.70"

python_prepare() {
	python_foreach_impl ./make_tr.py || die
	python_foreach_impl ./make_py_uic.py || die
	python_foreach_impl mv st-setup.py setup.py || die
	
}

pkg_postinst() {
	fdo-mime_mime_database_update
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	fdo-mime_mime_database_update
	xdg_desktop_database_update
	xdg_icon_cache_update
}
