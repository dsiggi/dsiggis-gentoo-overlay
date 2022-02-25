# Copyright 2020-2022 LiGurOs Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=6
PYTHON_COMPAT=( python3_{9,10} )

inherit distutils-r1 user

DESCRIPTION="LXDUI is a web UI for the native Linux container technology LXD/LXC"
HOMEPAGE="https://github.com/AdaptiveScale/lxdui"
SRC_URI="https://github.com/AdaptiveScale/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~arm ~arm64 x86"
IUSE=""

DEPEND="
	>=dev-python/click-6.7[${PYTHON_USEDEP}]
	>=dev-python/flask-1.0[${PYTHON_USEDEP}]
	>=dev-python/flask-login-0.4.1[${PYTHON_USEDEP}]
	>=dev-python/flask-jwt-extended-4.1.0[${PYTHON_USEDEP}]
	>=dev-python/jsonschema-2.6.0[${PYTHON_USEDEP}]
	>=dev-python/netaddr-0.7.19[${PYTHON_USEDEP}]
	>=dev-python/pylxd-2.2.7[${PYTHON_USEDEP}]
	>=dev-python/pyopenssl-17.5.0[${PYTHON_USEDEP}]
	>=dev-python/psutil-5.6.6[${PYTHON_USEDEP}]
	>=dev-python/requests-2.20.0[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/terminado-0.8.1[${PYTHON_USEDEP}]
	>=www-servers/tornado-5.0.2[${PYTHON_USEDEP}]
	dev-python/tornado-xstatic[${PYTHON_USEDEP}]
	>=dev-python/xstatic-1.0.1[${PYTHON_USEDEP}]
	>=dev-python/xstatic-termjs-0.0.7.0[${PYTHON_USEDEP}]
"

BDEPEND="dev-python/virtualenv"

RDEPEND="app-containers/lxd ${DEPEND}"

PATCHES=( "${FILESDIR}"/${P}-requirements.patch 
	  "${FILESDIR}"/lxdui-path.patch )

python_install_all() {
	dodir /etc/lxdui
	insinto /etc/lxdui
	doins conf/auth.conf
	doins conf/log.conf
	keepdir /var/log/lxdui
	dosym ../lib/python-exec/${EPYTHON}/lxdui /usr/sbin/lxdui
	insinto /usr/lib/${EPYTHON}/site-packages/conf/
	doins "${FILESDIR}"/lxdui.conf
	distutils-r1_python_install_all
}

pkg_postinst() {
	einfo "Please, run 'lxdui init' for setting and configuring lxdui"
}
