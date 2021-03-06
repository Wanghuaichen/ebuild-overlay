# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
inherit git-r3

DESCRIPTION="CUDE Miner Project"
HOMEPAGE="https://bitcointalk.org/?topic=770064"
EGIT_REPO_URI="https://github.com/tpruvot/ccminer.git"
EGIT_TAG="2.2.4-tpruvot"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"
DEPEND="dev-libs/openssl
	net-misc/curl
	>=dev-util/nvidia-cuda-toolkit-9.1
"

src_prepare() {
	eapply_user

	make distclean
	rm -f Makefile.in
	rm -f config.status
	aclocal
	autoheader
	automake --add-missing --gnu --copy
	autoconf
}

src_configure() {
	export CUDA_CFLAGS="-O3 -lineno -Xcompiler -Wall -D_FORCE_INLINES"
	export CXXFLAGS="${CXXFLAGS} -O3 -D_REENTRANT -falign-functions=16 -falign-jumps=16 -falign-labels=16"
	econf \
		--with-nvml=libnvidia-ml.so \
		 --with-cuda=/opt/cuda
}

src_install() {
  dobin ${S}/ccminer
  doinitd ${FILESDIR}/ccminer
}

pkg_postinst() {
  enewgroup nicehash
  enewuser nicehash -1 -1 /dev/null video
  elog
  elog "Remember to configure the algorithm, server and bitcoin address"
  elog "as appropriate in /etc/init.d/ccminer"
  elog
  elog "To automatically start the daemon on boot run"
  elog "# rc-update add ccminer default"
  elog
}

