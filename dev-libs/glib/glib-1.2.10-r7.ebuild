# Copyright 1999-2015 Gentoo Foundation
# Copyright 2016-2023 Michael Uleysky
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools libtool flag-o-matic portability multilib-minimal

DESCRIPTION="The GLib library of C routines"
HOMEPAGE="http://www.gtk.org/"
SRC_URI="mirror://gnome/sources/${PN}/$(ver_cut 1-2)/${PN}-${PV}.tar.gz"

LICENSE="LGPL-2.1+"
SLOT="1"
KEYWORDS="alpha amd64 arm hppa ia64 ~m68k ~mips ppc ppc64 ~s390 ~sh sparc x86 ~x86-fbsd"
IUSE="hardened static-libs"

DEPEND=""
RDEPEND=""

MULTILIB_CHOST_TOOLS=(/usr/bin/glib-config)

PATCHES=(
	"${FILESDIR}/${P}-automake.patch"
	"${FILESDIR}/${P}-m4.patch"
	"${FILESDIR}/${P}-configure-LANG.patch" #133679
	"${FILESDIR}/${P}-gcc34-fix.patch" #47047
	"${FILESDIR}/${P}-as-needed.patch" #133818
	"${FILESDIR}/${P}-automake-1.13.patch"
	"${FILESDIR}/${P}-inline.patch"
)

src_prepare() {
	default
	use ppc64 && use hardened && replace-flags -O[2-3] -O1
	sed -i "/libglib_la_LDFLAGS/i libglib_la_LIBADD = $(dlopen_lib)" Makefile.am || die

	rm -f acinclude.m4 #168198

	mv configure.in configure.ac || die

	eautoreconf
	elibtoolize
}

multilib_src_configure() {
	# Bug 48839: pam fails to build on ia64
	# The problem is that it attempts to link a shared object against
	# libglib.a; this library needs to be built with -fPIC.  Since
	# this package doesn't contain any significant binaries, build the
	# whole thing with -fPIC (23 Apr 2004 agriffis)
	append-flags -fPIC
	append-cflags -std=gnu89

	ECONF_SOURCE="${S}" \
	econf \
		--with-threads=posix \
		--enable-debug=no \
		$(use_enable static-libs static)
}

multilib_src_install() {
	default
	chmod 755 "${ED}"/usr/$(get_libdir)/libgmodule-1.2.so.* || die
}

multilib_src_install_all() {
	einstalldocs
	docinto html
	dodoc -r docs/*.html
}
