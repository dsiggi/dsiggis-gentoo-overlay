# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 xdg-utils pypi

DESCRIPTION="A simple GUI designer for the python tkinter module"
HOMEPAGE="https://github.com/alejandroautalan/pygubu-designer"
SRC_URI="$(pypi_sdist_url --no-normalize "${PN}" "${PV^}")"
KEYWORDS="~amd64 ~x86"
IUSE=""

LICENSE="GPL-3"
SLOT="0"

S=${WORKDIR}/${P}

RDEPEND="$(python_gen_cond_dep 'dev-python/appdirs[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/mako[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/pygubu[${PYTHON_USEDEP}]')"

python_install_all() {
	default
	newicon -s 256 "${WORKDIR}"/${P}/pygubudesigner/images/pygubuLogo/pyGubu_newLogo.svg ${PN}.svg
	make_desktop_entry /usr/bin/${PN} ${PN} /usr/share/icons/hicolor/256x256/apps/${PN}.svg Development
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
