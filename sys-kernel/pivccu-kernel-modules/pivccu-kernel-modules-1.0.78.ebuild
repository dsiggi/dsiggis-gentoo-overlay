# Copyright 1999-2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

DESCRIPTION="Kernel modules for HomeMatic modules."
HOMEPAGE="https://github.com/alexreinert/piVCCU"

COMMIT="584d36da27bcb03f43c8582784de97e45a819e7c"
SRC_URI="https://github.com/alexreinert/piVCCU/archive/${COMMIT}.zip -> ${P}.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm ~arm64"
IUSE=""

S=${WORKDIR}/piVCCU-${COMMIT}/kernel

MODULE_NAMES="eq3_char_loop(extra:${S}:${S})
		plat_eq3ccu2(extra:${S}:${S})
		generic_raw_uart(extra:${S}:${S})
		pl011_raw_uart(extra:${S}:${S})
		dw_apb_raw_uart(extra:${S}:${S})
		meson_raw_uart(extra:${S}:${S})
		fake_hmrf(extra:${S}:${S})
		rpi_rf_mod_led(extra:${S}:${S})
		dummy_rx8130(extra:${S}:${S})
		led_trigger_timer(extra:${S}:${S})
		hb_rf_usb(extra:${S}:${S})
		hb_rf_usb_2(extra:${S}:${S})
		hb_rf_eth(extra:${S}:${S})
		rtc-rx8130(extra:${S}:${S})"
BUILD_TARGETS="clean all"

inherit linux-info linux-mod

pkg_setup() {
	#cd ${S}/kernel
	linux-mod_pkg_setup
	BUILD_PARAMS="KERNELDIR=${KV_DIR}"
}

src_prepare() {
	eapply_user
}

src_configure() {
	set_arch_to_kernel
}

src_compile() {
	emake
}

src_install() {

	linux-mod_src_install

}

pkg_postinst() {
	linux-mod_pkg_postinst
}

