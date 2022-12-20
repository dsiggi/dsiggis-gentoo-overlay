# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{9,10} )

DISTUTILS_USE_SETUPTOOLS=rdepend
inherit distutils-r1

DESCRIPTION="Do external backup of your KVM guests, managed by libvirt, using the BlockCommit feature."
HOMEPAGE="https://github.com/aruhier/virt-backup"
SRC_URI="https://github.com/aruhier/${PN}/archive/v${PV}.tar.gz"
KEYWORDS="~amd64 ~x86"
IUSE="zstd"

DEPEND="$(python_gen_cond_dep 'dev-python/appdirs[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/defusedxml[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/libvirt-python[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/pyyaml[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/arrow[${PYTHON_USEDEP}]')
	zstd? ( $(python_gen_cond_dep 'dev-python/zstandard[${PYTHON_USEDEP}]') )"

LICENSE="BSD"
SLOT="0"

src_prepare() {
	sed -i -e "s/'pytest-runner', //" setup.py || die
	sed -i -e "s/\"argparse\", //" setup.py || die
	sed -i -e "s/\"packaging\", //" setup.py || die
	eapply_user
	python_copy_sources
}
