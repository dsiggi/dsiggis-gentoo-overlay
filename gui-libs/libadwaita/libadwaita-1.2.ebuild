# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{8..13} )
DISTUTILS_USE_PEP517=setuptools
VALA_MIN_API_VERSION="0.52"
inherit gnome.org meson python-any-r1 vala virtualx

DESCRIPTION="Building blocks for modern adaptive GNOME applications"
HOMEPAGE="https://gnome.pages.gitlab.gnome.org/libadwaita/ https://gitlab.gnome.org/GNOME/libadwaita"
SRC_URI="https://gitlab.gnome.org/GNOME/libadwaita/-/archive/${PV}.beta/libadwaita-${PV}.beta.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${PV}.beta"

LICENSE="LGPL-2.1+"
SLOT="1"
IUSE="+introspection test +vala"
REQUIRED_USE="vala? ( introspection )"

KEYWORDS="~amd64 ~arm ~arm64 ~ia64 ~loong ~ppc ~ppc64 ~riscv ~sparc ~x86"

DEPEND="
	>=dev-libs/glib-2.66:2
	>=gui-libs/gtk-4.5.0:4[introspection?]
	dev-libs/fribidi
	introspection? ( >=dev-libs/gobject-introspection-1.54:= )
	dev-lang/sassc
"
RDEPEND="${DEPEND}"
BDEPEND="
	${PYTHON_DEPS}
	vala? ( $(vala_depend) )
	>=dev-util/meson-0.59.0
	dev-util/glib-utils
	sys-devel/gettext
	virtual/pkgconfig
"

src_prepare() {
	default
	use vala && vala_setup
}

src_configure() {
	local emesonargs=(
		# Never use gi-docgen subproject
		--wrap-mode nofallback

		-Dprofiling=false
		$(meson_feature introspection)
		$(meson_use vala vapi)
		-Dgtk_doc=false # we ship pregenerated docs
		$(meson_use test tests)
		-Dexamples=false
	)
	meson_src_configure
}

src_test() {
	virtx meson_src_test --timeout-multiplier 2
}

src_install() {
	meson_src_install
}

