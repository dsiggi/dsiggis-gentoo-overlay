# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1

DESCRIPTION="Generates CNC gcode from 2D PCB files (Gerber/Excellon/SVG)"
HOMEPAGE="http://flatcam.org"
SRC_URI="https://bitbucket.org/jpcgt/flatcam/downloads/${PN}_beta_${PV}_sources.zip"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE=""

LICENSE="GPLv2"
SLOT="0"

DEPEND="dev-python/affine[${PYTHON_USEDEP}]
	dev-python/ezdxf[${PYTHON_USEDEP}]
	dev-python/freetype-py[${PYTHON_USEDEP}]
	dev-python/or-tools-python[${PYTHON_USEDEP}]
	dev-python/rasterio[${PYTHON_USEDEP}]
	dev-python/svglib[${PYTHON_USEDEP}]
	dev-python/vispy[${PYTHON_USEDEP}]
	dev-python/PyQt5[${PYTHON_USEDEP}]
	dev-python/qrcode[${PYTHON_USEDEP}]
	dev-python/simplejson[${PYTHON_USEDEP}]
	dev-python/cssselect2[${PYTHON_USEDEP}]
	dev-python/svg-path[${PYTHON_USEDEP}]
	dev-python/webencodings[${PYTHON_USEDEP}]
	dev-python/tinycss2[${PYTHON_USEDEP}]
	sci-libs/Shapely[${PYTHON_USEDEP}]
	sci-libs/Rtree[${PYTHON_USEDEP}]
	dev-python/matplotlib[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/fonttools[${PYTHON_USEDEP}]
	dev-python/pyopengl[${PYTHON_USEDEP}]
	dev-python/dill[${PYTHON_USEDEP}]
	dev-python/attrs[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	sci-libs/scipy[${PYTHON_USEDEP}]
	"

S=${WORKDIR}/${PN}_beta_${PV}_sources

#src_prepare() {
#	cp ${FILESDIR}/setup.py ${S}
#	sed -i "s/xxx/${PV}/g" ${S}/setup.py
#	rm -r ${S}/share/dark_resources
#	eapply_user
#}

src_compile() {
	elog ""
}

src_install() {
	insinto /usr/share/${PN}
	doins -r ${S}/*
}


