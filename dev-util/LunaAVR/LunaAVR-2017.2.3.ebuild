# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="6"

inherit eutils

DESCRIPTION="Luna ist eine objektorientierte, moderne Basic/Pascal-ähnliche Programmiersprache für Atmel AVR Mikrocontroller"
HOMEPAGE="http://http://avr.myluna.de/"
MY_PV="2017r2.3"
SRC_URI="http://avr.myluna.de/lib/exe/fetch.php?media=lunaavr-${MY_PV}-linux.tar.gz -> ${PF}.tar.gz"
LANGUAGES="de en"
IUSE="doc" #examples"
#URI for the Languafe Reference
R_VERSION="2017-02-26"
R_URI="http://avr.myluna.de/lib/exe/fetch.php?media=lunaavr-$R_VERSION"

for lang in ${LANGUAGES}; do
			IUSE+=" l10n_${lang%:*}"
			reference="l10n_${lang%:*}? ( doc? ( ${R_URI}-${lang}.pdf -> lunaavr-${R_VERSION}-${lang}.pdf ) )"
			SRC_URI+=" $reference"
done

#URI for the example projects
#E_VERSION="2016.r1-160501"
#E_URI="http://avr.myluna.de/lib/exe/fetch.php?media=luna-examples-${E_VERSION}.zip"
#E_FILE=${E_URI##*=}
#SRC_URI+=" examples? ( $E_URI -> $E_FILE )"

LICENSE="LunaAVR"
SLOT="0"
KEYWORDS="x86 amd64"


RDEPEND="x11-libs/gtk+:2
		 sys-libs/glibc
		 dev-libs/glib
		 virtual/libstdc++
		 dev-libs/icu
		 dev-embedded/avrdude"
DEPEND="${RDEPEND}"

S="${WORKDIR}/lunaavr-${MY_PV}-linux"

src_unpack(){
	unpack ${PF}.tar.gz
}

src_install() {
	#Install the package to /opt/LunaAVR
	dodir /opt/LunaAVR/
	cd "${S}"
	cp -R . "${D}/opt/LunaAVR/" || die "Install failed"

	#Install the bins
	bins="LunaAVR lavrc lavride"
	exeinto /opt/LunaAVR
	for b in $bins; do
		rm -f "${D}"/opt/LunaAVR/$b
		doexe "${S}"/$b
	done

	#Change the avrdude pathes in the config file
	sed -i "s!ProgDir = /home/rgf/PROJEKTE/lunaavr-2015r1.build7862-linux/avrdude/avrdude!ProgDir = /usr/bin/avrdude!g" "${S}"/LunaAVR.cfg
	sed -i "s!%home/avrdude.conf!/etc/avrdude.conf!g" "${S}"/LunaAVR.cfg

	#Install the config to /etc an make a symlink
	dodir /etc/
	insinto /etc/
	insopts	-m666
	doins "${S}"/LunaAVR.cfg
	rm -f ${D}/opt/LunaAVR/LunaAVR.cfg
	dosym /etc/LunaAVR.cfg /opt/LunaAVR/LunaAVR.cfg

	#Install the icons
	icon_sizes="16 32 48 64 128"
	for s in $icon_sizes; do
		doicon -s $s "${S}"/Icons/Luna-Icon-"$s"x"$s".png
	done

	#Install a menuentry
	#domenu "${FILESDIR}"/LunaAVR.desktop
	make_desktop_entry /opt/LunaAVR/LunaAVR LunaAVR /usr/share/icons/hicolor/64x64/apps/Luna-Icon-64x64.png Development


	#Install documentation
	if use doc; then
		for lang in ${LANGUAGES}; do
			if [ -f "${DISTDIR}"/lunaavr-${R_VERSION}-${lang}.pdf ]; then
				cp "${DISTDIR}"/lunaavr-${R_VERSION}-${lang}.pdf "${D}/opt/LunaAVR/Language Reference/"
			fi
		done
	fi

	#Install examples
#	if use examples; then
#		cd "${WORKDIR}/luna-examples-$E_VERSION/"
#		cp -R . "${D}"/opt/LunaAVR/Examples/
#	fi

	MAIN_RELEASE=$(cat "${D}"/opt/LunaAVR/CHANGES.TXT | head -n1 | cut -f3 -d" ")
	BUILD=$(grep build "${D}"/opt/LunaAVR/CHANGES.TXT | head -n1 | cut -f2 -d" ")

}

pkg_postinst(){
	if use doc; then
		elog "Installed Language Reference Version $R_VERSION"
	fi

	#if use examples; then
	#		elog "Installed examples Version $E_VERSION"
	#fi

	elog "Installed LunaAVR Main Release: $MAIN_RELEASE" 
	elog "BUILD: $BUILD"
}
