# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 desktop xdg-utils

DESCRIPTION="Desktop Backup Client for Borg Backup"
HOMEPAGE="https://vorta.borgbase.com/"
SRC_URI="https://github.com/borgbase/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"
IUSE=""

LICENSE="GPLv3"
SLOT="0"

DEPEND="$(python_gen_cond_dep 'app-backup/borgbackup[${PYTHON_USEDEP}]')
		$(python_gen_cond_dep 'dev-python/platformdirs[${PYTHON_USEDEP}]')
		$(python_gen_cond_dep 'dev-python/pyqt6[${PYTHON_USEDEP}]')
		$(python_gen_cond_dep 'dev-python/peewee[${PYTHON_USEDEP}]')
		$(python_gen_cond_dep 'dev-python/psutil[${PYTHON_USEDEP}]')
		$(python_gen_cond_dep 'dev-python/secretstorage[${PYTHON_USEDEP}]')
"

S=${WORKDIR}/${PN}-${PV}

python_install_all() {
	doicon -s scalable ${FILESDIR}/com.borgbase.Vorta.svg
	domenu ${FILESDIR}/vorta.desktop
	distutils-r1_python_install_all
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
