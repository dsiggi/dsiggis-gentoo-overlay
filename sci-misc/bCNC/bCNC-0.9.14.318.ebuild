# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..12} )
PYTHON_REQ_USE="tk"

inherit distutils-r1 desktop xdg-utils pypi

DESCRIPTION="Swiss army knife for all your CNC/g-code needs"
HOMEPAGE="https://pypi.org/project/bcnc/ https://github.com/vlachoudis/bCNC"
SRC_URI="$(pypi_sdist_url --no-normalize "${PN}" "${PV}")"
KEYWORDS="~amd64 ~x86"
IUSE="scipy +serial opencv"

LICENSE="GPLv2"
SLOT="0"

DEPEND="$(python_gen_cond_dep 'dev-python/pyserial[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/numpy[${PYTHON_USEDEP}]')
	scipy? ( $(python_gen_cond_dep 'dev-python/scipy[${PYTHON_USEDEP}]') )
	opencv? ( $(python_gen_cond_dep 'media-libs/opencv[${PYTHON_USEDEP},python]') )
	$(python_gen_cond_dep 'dev-python/pillow[${PYTHON_USEDEP}]')"

S=${WORKDIR}/${S}

python_prepare() {
	sed -i -e "s/find_packages()/find_packages(exclude=['tests'])/" setup.py || die
	sed -i -e '/opencv-python/d' setup.py || die

	#epatch ${FILESDIR}/box.patch
}

python_install_all() {
	default
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
