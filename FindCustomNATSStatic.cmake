# - Try to find LibXml2
# Once done this will define
#  NATS_STATIC_FOUND - System has LibXml2
#  NATS_STATIC_INCLUDE_DIRS - The LibXml2 include directories
#  NATS_STATIC_LIBRARIES - The libraries needed to use LibXml2
#  NATS_STATIC_DEFINITIONS - Compiler switches required for using LibXml2

#find_package(PkgConfig)
#pkg_check_modules(PC_LIBNATS REQUIRED nats)
set(NATS_STATIC_DEFINITIONS ${NATS_CFLAGS_OTHER})

find_path(NATS_STATIC_INCLUDE_DIR nats/nats.h
        HINTS ${NATS_INCLUDEDIR} ${NATS_INCLUDE_DIRS}
        PATH_SUFFIXES nats )

find_library(NATS_STATIC_LIBRARY NAMES nats.a libnats_static.a libnats.a
        HINTS ${NATS_LIBDIR} ${NATS_LIBRARY_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIETLY and REQUIRED arguments and set LIBNATS_STATIC_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(NATS_STATIC DEFAULT_MSG NATS_STATIC_LIBRARY NATS_STATIC_INCLUDE_DIR)

mark_as_advanced(NATS_STATIC_INCLUDE_DIR NATS_STATIC_LIBRARY )

set(NATS_STATIC_LIBRARIES ${NATS_STATIC_LIBRARY} )
set(NATS_STATIC_INCLUDE_DIRS ${NATS_STATIC_INCLUDE_DIR} )
