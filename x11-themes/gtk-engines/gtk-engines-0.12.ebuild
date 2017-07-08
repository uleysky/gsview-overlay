# Copyright 1999-2006 Gentoo Foundation
# Copyright 2016-2017 Michael Uleysky
# Distributed under the terms of the GNU General Public License v2

GNOME_TARBALL_SUFFIX="gz"
inherit gnome.org

DESCRIPTION="GTK+1 standard engines and themes"
HOMEPAGE="http://www.gtk.org/"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sh sparc x86"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*
	>=media-libs/imlib-1.8
	!>media-libs/imlib-1.9.15-r5"

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"
	dodoc AUTHORS ChangeLog README
}
