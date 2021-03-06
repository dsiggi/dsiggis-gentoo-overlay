# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1 eutils xdg-utils

DESCRIPTION="Generates CNC gcode from 2D PCB files (Gerber/Excellon/SVG)"
HOMEPAGE="http://flatcam.org"
SRC_URI="https://bitbucket.org/jpcgt/flatcam/downloads/${PN}_beta_${PV}_sources.zip"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE=""

LICENSE="GPLv2"
SLOT="0"

DEPEND="$(python_gen_cond_dep '>=dev-python/PyQt5-5.12.1[${PYTHON_USEDEP},printsupport]')
	$(python_gen_cond_dep '>=dev-python/numpy-1.16[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep '>=dev-python/matplotlib-3.1[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep '>=dev-python/cycler-0.10[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep '>=dev-python/python-dateutil-2.1[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep '>=dev-python/kiwisolver-1.1[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/six[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/dill[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'sci-libs/rtree[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/pyopengl[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/vispy[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep '>=dev-python/or-tools-python-7.0[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep '>=dev-python/svg-path-4.0[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/simplejson[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep '>=sci-libs/shapely-1.7[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/freetype-py[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/fonttools[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/rasterio[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/lxml[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/ezdxf[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep '>=dev-python/qrcode-6.1[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep '>=dev-python/reportlab-3.5[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/svglib[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'sci-libs/gdal[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep '>=dev-python/pyserial-3.4[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/cssselect2[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/click[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/affine[${PYTHON_USEDEP}]')
"

S=${WORKDIR}/${PN}_beta_${PV}_sources

src_compile() {
	#Nichts zu tun hier
	echo ""
}

src_install() {
	insinto /opt/${PN}
	doins -r ${S}/*

	exeinto /usr/bin/
	doexe ${FILESDIR}/${PN}

	doicon -s 128 "${FILESDIR}"/${PN}.png
	make_desktop_entry /usr/bin/${PN} ${PN} /usr/share/icons/hicolor/128x128/apps/${PN}.png Graphics
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
