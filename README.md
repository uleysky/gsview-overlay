# gsview-overlay
 Overlay for the gsview and some other plotting/scientific soft.

Gsview is a very old ghostscript-based viewer for postscript and pdf files. 
It's written on gtk1 and therefore was thrown out of the Gentoo repository along with gtk1.
There are many modern PS/PDF viewers, but gsview has a number of unique features that make it irreplaceable
when writing your own postscript code.
1) Presence of a ruler for measuring coordinates.
You can get the coordinates of any element of the picture in points, centimeters or inches.
It is useful, for example, when you need to insert only a selected area of a large eps file in a latex document.
2) Sequential rendering. You can see the drawing of the picture as the file is processed. Sometimes useful, always fun.
3) Magnification of the picture fragment. There is no need to wait drawing the whole picture in high resolution,
so the magnification can be made very large.

For gsview we need gtk+-1.2 and glib-1.2. In order not to cry bloody tears, it's better to install gtk-engines,
which depends on imlib.

Also in this repository are ebuilds for the GMT (Generic Mapping Tools, http://gmt.soest.hawaii.edu/).
