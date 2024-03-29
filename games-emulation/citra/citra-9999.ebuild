# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3 flag-o-matic

DESCRIPTION="Nintendo 3DS Emulator"
HOMEPAGE="https://citra-emu.org/"

EGIT_REPO_URI="https://github.com/citra-emu/citra.git"
# These are used by citra and externals/dynarmic which seems to break with git-r3.eclass
EGIT_SUBMODULES=("*" "-externals/dynarmic/externals/fmt" "-externals/dynarmic/externals/xbyak")

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="system-boost doc sdl2 qt5 clang telemetry i18n ffmpeg discord"

REQUIRED_USE="|| ( sdl2 qt5 )"
RDEPEND="virtual/opengl
	media-libs/libpng:=
	sys-libs/zlib
	net-misc/curl
	system-boost? ( >=dev-libs/boost-1.66.0:= )
	sdl2? ( media-libs/libsdl2 )
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtconcurrent:5
		dev-qt/qtgui:5
		dev-qt/qtmultimedia:5
		dev-qt/qtopengl:5
		dev-qt/qtwidgets:5
	)
	ffmpeg? ( media-video/ffmpeg:= )
	!ffmpeg? ( media-libs/fdk-aac:= )"
DEPEND="${DEPEND}
	>=dev-util/cmake-3.8
	doc? ( >=app-doc/doxygen-1.8.8[dot] )
	!clang? ( >=sys-devel/gcc-7 )
	clang? (
		>=sys-devel/clang-5
		>=sys-libs/libcxx-5
	)
	qt5? ( i18n? ( dev-qt/linguist-tools:5 ) )"

pkg_pretend() {
	if ! use clang; then
		if [[ $(gcc-major-version) -lt 7 ]]; then
			die "Need GCC 7 of newer to compile citra"
		fi
	fi
}

src_unpack() {
	git-r3_src_unpack

	for i in fmt xbyak; do
		cp -a "${S}/externals/$i" "${S}/externals/dynarmic/externals/" || die
	done
}

src_configure() {
	if use clang; then
		export CC=clang
		export CXX=clang++
		append-cxxflags "-stdlib=libc++" # Upstream requires libcxx when building with clang
	fi

	local mycmakeargs=(
		-DENABLE_QT="$(usex qt5)"
		-DENABLE_SDL2="$(usex sdl2)"
		-DCITRA_USE_BUNDLED_SDL2=OFF
		-DCITRA_USE_BUNDLED_QT=OFF
		-DCITRA_USE_BUNDLED_FFMPEG=OFF
		-DENABLE_QT_TRANSLATION="$(usex i18n)"
		-DENABLE_WEB_SERVICE="$(usex telemetry)"
		-DUSE_SYSTEM_BOOST="$(usex system-boost)"
		-DENABLE_FFMPEG_AUDIO_DECODER="$(usex ffmpeg)"
		-DENABLE_FFMPEG_VIDEO_DUMPER="$(usex ffmpeg)"
		-DUSE_DISCORD_PRESENCE="$(usex discord)"
	)
	cmake_src_configure
}

src_compile() {
	cmake_src_compile
	if use doc; then
		doxygen || die
	fi
}

src_install() {
	cmake_src_install
	dodoc README.md CONTRIBUTING.md
	use doc && dodoc -r doc-build/html
}

pkg_postinst() {
	if use i18n; then
		elog "Translations only work with the Qt5 interface"
	fi
}
