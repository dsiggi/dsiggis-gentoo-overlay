# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit eutils linux-info linux-mod

MY_P=rr232x-linux-src-v${PV}-090716-0928
DESCRIPTION="Paragon NTFS & HFS+ for Linux driver "
HOMEPAGE="https://www.paragon-software.com/home/ntfs-linux-per/"
SRC_URI="https://dl.paragon-software.com/free/Paragon_NTFS_for_Linux_driver_Retail_Express_lke_${PV}.tar.gz"

LICENSE="paragon-ntfs"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="!!sys-fs/ntfs3g"

S=${WORKDIR}
BUILD_PARMS="KERN_DIR=${KV_DIR} KERNOUT=${KV_OUT_DIR} driver retail=1"

src_unpack() {
	default
	linux-mod_pkg_setup
}

src_configure() {
	cd ${S}
	set_arch_to_kernel
	default
}

src_compile() {
	cd ${S}
	emake ${BUILD_PARMS}
}

src_install() {
	cd ${S}

	insinto /lib/modules/${KV_FULL}/kernel/external/ufsd
	doins ufsd.ko
	doins jnl.ko

	exeinto /usr/sbin
	doexe ${FILESDIR}/mount.paragon-ufsd
	dosym mount.paragon-ufsd /usr/sbin/mount.ntfs
	dosym mount.paragon-ufsd /usr/sbin/mount.hfsplus
}

pkg_postinst() {
	linux-mod_pkg_postinst
}
