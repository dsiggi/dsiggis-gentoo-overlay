# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=poetry
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1 desktop xdg-utils

COMMIT="19d9eb4f42f6396ab462c4d59c6aa81b9596bcf0"
DESCRIPTION="Generates CNC gcode from 2D PCB files (Gerber/Excellon/SVG)"
HOMEPAGE="http://flatcam.org"
SRC_URI="https://bitbucket.org/marius_stanciu/flatcam_beta/get/${COMMIT}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE=""

LICENSE="GPLv2"
SLOT="0"

RDEPEND="$(python_gen_cond_dep '>=dev-python/numpy-1.16[${PYTHON_USEDEP}]')
		$(python_gen_cond_dep '>=dev-python/cycler-0.10[${PYTHON_USEDEP}]')
		$(python_gen_cond_dep '>=dev-python/python-dateutil-2.1[${PYTHON_USEDEP}]')
		$(python_gen_cond_dep '>=dev-python/kiwisolver-1.1[${PYTHON_USEDEP}]')
		$(python_gen_cond_dep 'dev-python/six[${PYTHON_USEDEP}]')
		$(python_gen_cond_dep 'dev-python/dill[${PYTHON_USEDEP}]')
		$(python_gen_cond_dep 'dev-python/simplejson[${PYTHON_USEDEP}]')
		$(python_gen_cond_dep '>=dev-python/qrcode-6.1[${PYTHON_USEDEP}]')
		$(python_gen_cond_dep 'dev-python/rtree[${PYTHON_USEDEP}]')
		$(python_gen_cond_dep '>=dev-python/shapely-2.0[${PYTHON_USEDEP}]')
		$(python_gen_cond_dep 'dev-python/lxml[${PYTHON_USEDEP}]')
		$(python_gen_cond_dep '>=dev-python/svg-path-4.0[${PYTHON_USEDEP}]')
		$(python_gen_cond_dep 'dev-python/svglib[${PYTHON_USEDEP}]')
		$(python_gen_cond_dep 'dev-python/fonttools[${PYTHON_USEDEP}]')
		$(python_gen_cond_dep '>=dev-python/ezdxf-1.4.2[${PYTHON_USEDEP}]')
		$(python_gen_cond_dep '>=dev-python/reportlab-3.5[${PYTHON_USEDEP}]')
		$(python_gen_cond_dep '>=dev-python/pyserial-3.4[${PYTHON_USEDEP}]')
		$(python_gen_cond_dep '>=dev-python/pikepdf-2.0[${PYTHON_USEDEP}]')
		$(python_gen_cond_dep '>=dev-python/matplotlib-3.5[${PYTHON_USEDEP}]')
		$(python_gen_cond_dep 'dev-python/pyopengl[${PYTHON_USEDEP}]')
		$(python_gen_cond_dep 'dev-python/pyqt6[${PYTHON_USEDEP},printsupport]')
		$(python_gen_cond_dep 'dev-python/freetype-py[${PYTHON_USEDEP}]')
		$(python_gen_cond_dep '>=dev-python/vispy-0.9.0[${PYTHON_USEDEP}]')
		$(python_gen_cond_dep 'dev-python/darkdetect[${PYTHON_USEDEP}]')
		$(python_gen_cond_dep '>=sci-libs/gdal-3.11[${PYTHON_USEDEP}]')
		$(python_gen_cond_dep 'dev-python/rasterio[${PYTHON_SINGLE_USEDEP}]')
		$(python_gen_cond_dep 'dev-python/hsluv[${PYTHON_USEDEP}]')
		$(python_gen_cond_dep 'dev-python/typing-extensions[${PYTHON_USEDEP}]')
"

S=${WORKDIR}/marius_stanciu-flatcam_beta-${COMMIT::12}


src_compile() {
	# Nothin to do
	sleep 0.1
}

src_install() {
	insinto /opt/${PN}
	doins -r ${S}/*

	exeinto /usr/bin/
	doexe ${FILESDIR}/${PN}

	doicon -s 128 "${FILESDIR}"/${PN}.png
	make_desktop_entry /usr/bin/${PN} ${PN} /usr/share/icons/hicolor/128x128/apps/${PN}.png Electronics
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
