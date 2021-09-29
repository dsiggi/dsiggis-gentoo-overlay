# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9} )
inherit distutils-r1

DESCRIPTION="MicroPython Project Management Tool"
HOMEPAGE="https://github.com/BradenM/micropy-cli"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="$(python_gen_cond_dep 'dev-python/colorama[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/rshell[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep '=dev-python/click-7*[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/requirements-parser[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/tqdm[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/questionary[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/jsonschema[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep '<dev-python/dpath-2[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/cachier[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep '<dev-python/boltons-20[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/GitPython[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/prompt_toolkit[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep '=dev-python/jinja-2*[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep '<dev-python/packaging-21[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/typing-extensions[${PYTHON_USEDEP}]')
"

RDEPEND="${DEPEND}"
BDEPEND=""

function postinst() {
	cp ${S}/micropy/project/template/.gitignore ${D}/usr/lib/${EPYTHON}/site-packages/micropy/project/template/
	cp ${S}/micropy/project/template/.pylintrc ${D}/usr/lib/${EPYTHON}/site-packages/micropy/project/template/
}

pkg_preinst() {
	python_foreach_impl postinst
}
