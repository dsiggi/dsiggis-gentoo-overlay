# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=( python3_{8,9,10} )
inherit eutils xdg-utils distutils-r1

PKG_POST_NAME=""

DESCRIPTION="A multitrack non-linear video editor"
HOMEPAGE="https://github.com/jliljebl/flowblade"

SRC_URI="${HOMEPAGE}/archive/v${PV}${PKG_POST_NAME}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~x86 ~amd64"
S="${WORKDIR}/${P}/${PN}-trunk"

LICENSE="LGPL-3"
SLOT="0"
IUSE=""

DEPEND="
	${PYTHON_DEPS}
	>=x11-libs/gtk+-3.0:3
	$(python_gen_any_dep 'dev-python/pygobject:3[cairo,${PYTHON_USEDEP}]' )
	>=media-libs/mlt-6.18.0[python,ffmpeg,gtk]
	$(python_gen_any_dep 'dev-python/dbus-python[${PYTHON_USEDEP}]' )
	media-plugins/frei0r-plugins
	media-plugins/swh-plugins
	$(python_gen_any_dep 'dev-python/pycairo[${PYTHON_USEDEP}]')
	$(python_gen_any_dep 'dev-python/numpy[${PYTHON_USEDEP}]' )
	$(python_gen_any_dep 'dev-python/pillow:0[${PYTHON_USEDEP}]' )
	gnome-base/librsvg:2=
	media-gfx/gmic[ffmpeg,X]
	dev-libs/glib:2[dbus]
	x11-libs/gdk-pixbuf:2[X]
	media-video/ffmpeg
"
RDEPEND="${DEPEND}"

src_prepare()
{
	cd ${WORKDIR}/${P}/flowblade-trunk/
	sed -i 's/import processutils/from Flowblade import processutils/g' flowblade
	sed -i 's/import app/from Flowblade import app/g' flowblade
	sed -i 's/import editorstate/from Flowblade import editorstate/g' flowblade

	cd Flowblade/
	declare -A files=()
	ordner="launch tools vieweditor"

	#Dateien auflisten
	for o in $ordner; do
		cd $o
		files[$o]=$(ls)
		cd ..
	done
	files[root]=$(ls *.py)

	#Patchen der Dateien in allen Unterordnern
	for o in $ordner; do
		for f in ${files[$o]}; do
			elog "Patche Datei:" $o/$f
			for i in ${files[$o]}; do
				foe=${i%*.py}
				sed -i "s/\bimport $foe\b/from Flowblade.$o import $foe/g" $o/$f
				sed -i "s/from $foe/from Flowblade.$o.$foe/g" $o/$f
			done
			for d in $ordner; do
				if [ $d = $o ]; then
					continue
				else
					for i in ${files[$d]}; do
						foe=${i%*.py}
						sed -i "s/\bimport $foe\b/from Flowblade.$d import $foe/g" $o/$f
						sed -i "s/from $foe/from Flowblade.$d.$foe/g" $o/$f
					done
				fi
			done

			for i in ${files[root]}; do
				foe=${i%*.py}
				sed -i "s/\bimport $foe\b/from Flowblade import $foe/g" $o/$f
				sed -i "s/from $foe/from Flowblade.$foe/g" $o/$f
			done
		done
	done

	#Patchen der Dateien im Root-Ordner
	for f in ${files[root]}; do
		elog "Patche Datei:" $f
		for i in ${files[root]}; do
			foe=${i%*.py}
			sed -i "s/\bimport $foe\b/from Flowblade import $foe/g" $f
			sed -i "s/from $foe/from Flowblade.$foe/g" $f
		done
		#Und jetzt noch die Dateien der Unterordner prüfen
		for o in $ordner; do
			for i in ${files[$o]}; do
				foe=${i%*.py}
				sed -i "s/\bimport $foe\b/from Flowblade.$o import $foe/g" $f
				sed -i "s/from $foe/from Flowblade.$o.$foe/g" $f
			done
		done
	done

	default

}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
 
