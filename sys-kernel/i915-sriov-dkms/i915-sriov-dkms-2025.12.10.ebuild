# Copyright 1999-2025 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=8

DESCRIPTION="dkms module of Linux i915 driver with SR-IOV support"
HOMEPAGE="https://github.com/strongtz/i915-sriov-dkms"

SRC_URI="https://github.com/strongtz/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S=${WORKDIR}/${P}
MODULES_KERNEL_MIN=6.12
MODULES_KERNEL_MAX=6.18

inherit linux-mod-r1


pkg_pretend() {
	linux_config_exists || die
	if ! linux_chkconfig_module DRM_I915; then
		eerror "the i915 driver needs to be a module!"
		die
	fi
}


src_compile() {
    MODULES_MAKEARGS+=(
        KERNEL_DIR="${KV_DIR}"
        M="${S}"
        -C ${KV_DIR})

    emake "${MODULES_MAKEARGS[@]}"

}

src_install() {
	linux_moduleinto kernel/drivers/gpu/drm/i915
	linux_domodule drivers/gpu/drm/i915/i915.ko
	linux_domodule drivers/gpu/drm/i915/kvmgt.ko
	modules_post_process # strip->sign->compress

	rm ${D}/usr/lib/dracut/dracut.conf.d/10-i915-sriov-dkms.conf 
}
