# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7
WX_GTK_VER=3.0
inherit autotools plocale readme.gentoo-r1 systemd wxwidgets

PLOCALES="cs da de es fa fr it nl pl pt_BR ru sk uk zh_CN zh_TW"

DESCRIPTION="Client for UrBackup server"
HOMEPAGE="https://www.urbackup.org"
SRC_URI="https://hndl.urbackup.org/Client/${PV}/${P}.tar.gz"
S=${WORKDIR}/${P}.0

SLOT="0"
LICENSE="AGPL-3"
KEYWORDS="~amd64 ~x86"
IUSE="debug hardened nls systemd X system-cryptopp"

RDEPEND="dev-db/sqlite:3
	system-cryptopp? ( dev-libs/crypto++:0= )
	dev-libs/icu:0=
	sys-libs/zlib:0=
	X? ( x11-libs/wxGTK:3.0 )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	!systemd? ( app-admin/logrotate )"

src_prepare() {
	default

	# Remove key, version for client autoupdate and info.txt
	sed -i  -e '/\/client\/data\/urbackup_ecdsa409k1.pub/d' \
		-e 's|client/data/urbackup_ecdsa409k1.pub ||' \
		-e '/\/client\/version.txt/d' \
		-e 's|client/version.txt ||' \
		-e '/\/client\/info.txt/d' \
		-e 's|client/info.txt ||' \
		Makefile.am || die "sed failed for Makefile.am"

	remove_locale() {
		sed -i -e "/\/urbackup\/lang\/${1}/d" \
			Makefile.am || die "sed failed to remove locale"
	}
	plocale_for_each_disabled_locale_do remove_locale

	eautoreconf
}

src_configure() {
	econf "$(usex hardened --enable-fortify "")" \
		"$(use_enable debug assertions)" \
		"$(use_enable !X headless)" \
		"$(use_enable !system-cryptopp embedded-cryptopp)" \
		--without-embedded-sqlite3 \
		--disable-clientupdate \
		--enable-embedded-zstd
}

src_install() {
	default

	doman docs/urbackupclientbackend.1

	keepdir /var/lib/urbackup/data

	insinto /etc/logrotate.d
	newins "${FILESDIR}"/urbackup-client.logrotate urbackup-client

	if ! use systemd ; then
		newinitd "${FILESDIR}"/urbackup-client.initd urbackup-client
		newconfd "${FILESDIR}"/urbackup-client.confd urbackup-client
	else
		systemd_dounit "${FILESDIR}"/urbackup-client.service
	fi

	exeinto /usr/share/urbackup
	for f in btrfs dattobd lvm; do
		doexe ${FILESDIR}/${f}_create_filesystem_snapshot
		doexe ${FILESDIR}/${f}_remove_filesystem_snapshot
	done
	
	insinto /etc/urbackup
	doins "${FILESDIR}"/urbackup-client
}
