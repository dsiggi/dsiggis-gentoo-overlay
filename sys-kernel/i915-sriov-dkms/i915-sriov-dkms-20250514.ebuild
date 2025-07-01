# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=8

DESCRIPTION="dkms module of Linux i915 driver with SR-IOV support"
HOMEPAGE="https://github.com/strongtz/i915-sriov-dkms"

COMMIT="4de11bfac15ceb2780641b0abc0aac3496abb3d7"
SRC_URI="https://github.com/strongtz/${PN}/archive/${COMMIT}.zip -> ${P}.zip"

LICENSE="GPL-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S=${WORKDIR}/${PN}-${COMMIT}

MODULE_NAMES="i915(kernel/drivers/gpu/drm/i915:${S}:${S})
				kvmgt(kernel/drivers/gpu/drm/i915:${S}:${S})"
BUILD_TARGETS="clean"

inherit linux-info linux-mod

pkg_pretend() {
	linux_config_exists || die
	if ! linux_chkconfig_module DRM_I915; then
		eerror "the i915 driver needs to be a module!"
		die
	fi
}

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="KERNELDIR=${KV_DIR}"
}

src_configure() {
	set_arch_to_kernel
}

src_compile() {
	emake KERNELRELEASE=${KV_FULL} -C /lib/modules/${KV_FULL}/build M=${S}
}

src_install() {
	linux-mod_src_install
}

pkg_postinst() {
	linux-mod_pkg_postinst

	einfo
	einfo "Remove the i915.ko and kvmgt.ko module from /lib/modules/${KV_FULL}/kernel/drivers/gpu/drm/i915!"

	einfo "The i915 kernel module will be available on reboot."
	einfo "Please refer to https://github.com/strongtz/i915-sriov-dkms/blob/master/README.md to set kernel parameters."
}

