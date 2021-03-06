# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
inherit eutils cmake-utils git-r3

DESCRIPTION="A 2d physics library"
HOMEPAGE="http://box2d.org/"
EGIT_REPO_URI="git://github.com/erincatto/Box2D.git"
LICENSE="ZLIB"
SLOT="0"
DEPEND="app-arch/unzip"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"

src_prepare() {
	CMAKE_USE_DIR="${S}/Box2D"
	cmake-utils_src_prepare
}

src_configure() {
	mycmakeargs=(
		-DBOX2D_BUILD_EXAMPLES=OFF
		-DBOX2D_BUILD_SHARED=ON
		-DCMAKE_CXX_FLAGS:STRING=-std=c++11
	)

	CMAKE_USE_DIR="${S}/Box2D"
	cmake-utils_src_configure
}
