# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

DESCRIPTION="Kernel module and userland tools for taking block-level snapshots and backups."
HOMEPAGE="http://www.datto.com"
SRC_URI="https://github.com/datto/${PN}/archive/v${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="net-misc/rsync dev-lang/perl"

MODULE_NAMES="dattobd(extra:${S}:${S}/src)"
BUILD_TARGETS="clean all"

inherit linux-info linux-mod

pkg_setup() {
	linux-mod_pkg_setup
}

src_prepare() {
	if kernel_is -ge 5 8; then
		epatch ${FILESDIR}/kernel_5.8.patch
	fi
	eapply_user
}

src_configure() {
	set_arch_to_kernel
}

src_compile() {
	emake
}

src_install() {
	mkdir -p include/dattobd
	cp src/*.h include/dattobd/.
	cp lib/*.h include/dattobd/.
	doheader -r include/*
	dolib lib/*.so*
	dolib.a lib/*.a
	dosbin app/dbdctl
	dosbin utils/update-img
	linux-mod_src_install

}

pkg_postinst() {
	linux-mod_pkg_postinst
}

