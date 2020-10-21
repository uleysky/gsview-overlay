cmake_minimum_required(VERSION 3.0)

project(gswteos-10)

add_library(gswteos-10 SHARED gsw_saar.c gsw_oceanographic_toolbox.c)

install(TARGETS gswteos-10 DESTINATION lib)
install(FILES gswteos-10.h DESTINATION include)
