# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# https://github.com/OrcaSlicer/OrcaSlicer/issues/11032

EAPI=8

WX_GTK_VER="3.2-gtk3"
CMAKE_BUILD_TYPE="Release"

inherit cmake desktop wxwidgets xdg

DESCRIPTION="G-code generator for 3D printers (Bambu, Prusa, Voron, VzBot, RatRig, Creality, etc.)"
HOMEPAGE="https://www.orcaslicer.com/"
SRC_URI="https://github.com/SoftFever/OrcaSlicer/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

# Long story short, It's APGL3, with code forked from other AGPL3 slicers.
# It includes some code for a "pressure advance calibration pattern test" which is GPL3
LICENSE="AGPL3 GPL3"
SLOT="0"
KEYWORDS="~amd64" # WIP
IUSE="video"
DEPEND="
	net-misc/curl[ssl]
	sys-apps/dbus
	gui-libs/eglexternalplatform
	sys-apps/file
	sys-devel/gettext
	media-libs/glew
	media-libs/glfw
	media-libs/gstreamer
	gui-libs/gtk
	dev-libs/libmspack
	app-crypt/libsecret
	dev-libs/libspnav
	dev-build/libtool
	virtual/libudev
	media-libs/glu
	net-libs/webkit-gtk
	dev-libs/boost
	media-gfx/openvdb[utils]
	dev-libs/imath
	media-libs/opencv
	dev-libs/libnoise
	media-libs/qhull[static-libs]
	video? (
		x11-libs/wxGTK:${WX_GTK_VER}[webkit,curl,gstreamer]
	)
	!video? (
		x11-libs/wxGTK:${WX_GTK_VER}[webkit,curl]
	)
	sci-mathematics/cgal:=
	sci-libs/opencascade
	dev-libs/cereal
	sci-libs/nlopt
"
RDEPEND="
	${DEPEND}
"
BDEPEND="
	virtual/pkgconfig
	dev-build/ninja
	sys-apps/ripgrep
"
S="${WORKDIR}/${P}"

PATCHES=(
	# the cmake build unconditionally adds --toolkit to the wx-config call, which fails at least on some setups
	"${FILESDIR}/wxwidgets_no_multislot.patch"
	# slic3r_fixes.patch is mostly from https://github.com/supermerill/SuperSlicer/pull/4635/commits/c9ba132c329a80b8f7116e86576dd8e6c669a08a
	"${FILESDIR}/slic3r_fixes.patch"
)

# TODO: improve and document these changes. maybe convert it all to patches?
# We are linking here against a newer boost and CGAL than this version of slic3r is supposed to take, cause these are the only vers availible in gentoo.
# slic3r_fixes.patch is mostly from https://github.com/supermerill/SuperSlicer/pull/4635/commits/c9ba132c329a80b8f7116e86576dd8e6c669a08a
# I forget where the cmake modules are from, but they are edited from stuff I found on the web. IDK if its linking right with system libs.
src_prepare() {
	# wxwidget's "media" property is in fact gstreamer support; if wxGTK is not compiled with it, the configure fails
	if ! use video; then
		PATCHES+=( "${FILESDIR}/orcaslicer-no-media.patch" )
	fi

	rm "${S}/cmake/modules/FindOpenVDB.cmake" "${S}/cmake/modules/OpenVDBUtils.cmake" || die
	cp "${FILESDIR}/FindOpenVDB.cmake" "${S}/cmake/modules/FindOpenVDB.cmake" || die
	cp "${FILESDIR}/OpenVDBUtils.cmake" "${S}/cmake/modules/OpenVDBUtils.cmake" || die
	cp "${FILESDIR}/FindBlosc.cmake" "${S}/cmake/modules/FindBlosc.cmake" || die
	cp "${FILESDIR}/BoostProcessCompat.hpp" "${S}/src/libslic3r/BoostProcessCompat.hpp" || die

	pushd "${S}/deps_src/libigl/igl/copyleft/cgal" || die
		rg -l "AABB_traits\.h" | while read file; do sed -i 's/AABB_traits\.h/AABB_traits_3\.h/g' $file ; done || die
		rg -l "AABB_triangle_primitive\.h" | while read file; do sed -i 's/AABB_triangle_primitive\.h/AABB_triangle_primitive_3\.h/g' $file ; done || die
		rg -l "CGAL::AABB_traits" | while read file; do sed -i 's/CGAL::AABB_traits/CGAL::AABB_traits_3/g' $file ; done || die
		rg -l "CGAL::AABB_triangle_primitive" | while read file; do sed -i 's/CGAL::AABB_triangle_primitive/CGAL::AABB_triangle_primitive_3/g' $file ; done || die
	popd
	pushd "${S}/src/libslic3r/" || die
		rg -l "CGAL::AABB_traits" | while read file; do sed -i 's/CGAL::AABB_traits/CGAL::AABB_traits_3/g' $file ; done || die
	popd
	pushd "${S}/src/slic3r/" || die
		rg -l "directory_iterator" | while read file; do sed -i 's/operations.hpp/directory.hpp/g' $file ; done || die
	popd

	cmake_src_prepare
}

src_configure() {
	setup-wxwidgets unicode
	local mycmakeargs=(
		-DSLIC3R_GTK=3
		-DSLIC3R_STATIC=OFF
		-DSLIC3R_FHS=1
		-DSLIC3R_PCH=0

		-DBBL_RELEASE_TO_PUBLIC=1
		-DBBL_INTERNAL_TESTING=0

		-DwxWidgets_USE_UNICODE=ON
		-DwxWidgets_USE_STATIC=OFF

		-DORCA_TOOLS=ON
		-DUSE_BLOSC=TRUE

		-Wno-dev
	)
	cmake_src_configure
}

src_compile() {
	cmake_src_compile
	# Generate i18n-files
	cd ${S}
	./scripts/run_gettext.sh
}

src_install() {
	cmake_src_install
	default
	rm "${D}/usr/LICENSE.txt" || die
	rm -r "${D}/usr/include" || die
	rm -r "${D}/usr/lib" || die
}

pkg_postinst() {
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
	xdg_desktop_database_update
	if ! use video; then
		einfo "\nMissing gstreamer support in wxGTK and/or USE=\"-video\" in this package will most likely break printer camera features"
	fi
}

pkg_postrm() {
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
	xdg_desktop_database_update
}
