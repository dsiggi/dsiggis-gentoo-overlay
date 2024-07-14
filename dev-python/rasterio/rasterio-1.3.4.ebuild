# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517="setuptools"
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1 pypi

DESCRIPTION="Fast and direct raster I/O for use with Numpy and SciPy"
HOMEPAGE="https://pypi.org/project/rasterio/ https://github.com/mapbox/rasterio"
SRC_URI="$(pypi_sdist_url "${PN^}" "${PV}")"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE="plot s3"

DEPEND="$(python_gen_cond_dep '>sci-libs/gdal-3.3.0[${PYTHON_SINGLE_USEDEP},python]' )
	$(python_gen_cond_dep 'dev-python/numpy[${PYTHON_USEDEP}]' )"
RDEPEND="$(python_gen_cond_dep 'dev-python/affine[${PYTHON_USEDEP}]' )
	 $(python_gen_cond_dep 'dev-python/attrs[${PYTHON_USEDEP}]' )
	 $(python_gen_cond_dep 'dev-python/click[${PYTHON_USEDEP}]' )
	 $(python_gen_cond_dep 'dev-python/click-plugins[${PYTHON_USEDEP}]' )
	 $(python_gen_cond_dep 'dev-python/cligj[${PYTHON_USEDEP}]' )
	 $(python_gen_cond_dep 'dev-python/snuggs[${PYTHON_USEDEP}]' )
	 $(python_gen_cond_dep 'dev-python/hypothesis[${PYTHON_USEDEP}]' )
	 $(python_gen_cond_dep 'dev-python/shapely[${PYTHON_USEDEP}]' )
	 s3? ( $(python_gen_cond_dep 'dev-python/boto3[${PYTHON_USEDEP}]' ) )
	 plot? ( $(python_gen_cond_dep 'dev-python/matplotlib[${PYTHON_USEDEP}]' ) )"

LICENSE="BSD"
SLOT="0"
