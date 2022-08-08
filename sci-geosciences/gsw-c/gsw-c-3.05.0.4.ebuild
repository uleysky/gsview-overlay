# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="TEOS-10 GSW Oceanographic Toolbox in C"
HOMEPAGE="https://github.com/TEOS-10/GSW-C"

if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI="https://github.com/TEOS-10/GSW-C.git"
	INHERIT_GIT="git-r3"
	MY_P="${P}"
else
	MY_PV=$(ver_rs 3 '-')
	INHERIT_GIT=""
	SRC_URI="https://github.com/TEOS-10/GSW-C/archive/${MY_PV}.tar.gz -> GSW-C-${MY_PV}.tar.gz"
	S="${WORKDIR}/GSW-C-${MY_PV}"
	KEYWORDS="~amd64 ~x86 ~arm ~arm64"
fi

inherit cmake ${INHERIT_GIT}

LICENSE="Artistic"
SLOT="0"

RDEPEND=""
DEPEND="${RDEPEND}"

src_prepare() {
	cp "${FILESDIR}"/CMakeLists.txt "${S}" || die
	sed \
		-e "/DESTINATION/s:lib:$(get_libdir):g" \
		-e "/INSTALL/s:lib:$(get_libdir):g" \
		-i CMakeLists.txt || die
	cmake_src_prepare
}
