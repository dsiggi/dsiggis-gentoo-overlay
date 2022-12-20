# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7
COMMIT="32427600aa4325beda385678897133a8218c1371"
DESCRIPTION="Kernel module and userland tools for taking block-level snapshots and backups."
HOMEPAGE="https://github.com/elastio/elastio-snap"
SRC_URI="https://github.com/elastio/elastio-snap/archive/${COMMIT}.zip -> ${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="net-misc/rsync dev-lang/perl"

S=${WORKDIR}/${PN}-${COMMIT}
MODULE_NAMES="elastio-snap(extra:${S}:${S}/src)"
BUILD_TARGETS="clean all"

inherit linux-info linux-mod

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="KERNELDIR=${KV_DIR}"
}

src_configure() {
	set_arch_to_kernel
}

src_compile() {
	emake
}

src_install() {
	cd ${S}
	mkdir -p include/elastio-snap
	cp src/*.h include/elastio-snap/.
	cp lib/*.h include/elastio-snap/.
	doheader -r include/*
	dolib lib/*.so*
	dolib.a lib/*.a
	dosbin app/elioctl
	dosbin utils/update-img
	linux-mod_src_install

}

pkg_postinst() {
	linux-mod_pkg_postinst
}

