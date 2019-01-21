# - Try to find LibXml2
# Once done this will define
#  WDB_STATIC_FOUND - System has LibXml2
#  WDB_STATIC_INCLUDE_DIRS - The LibXml2 include directories
#  WDB_STATIC_LIBRARIES - The libraries needed to use LibXml2
#  WDB_STATIC_DEFINITIONS - Compiler switches required for using LibXml2

set(WDB_STATIC_DEFINITIONS ${WDB_CFLAGS_OTHER})

find_path(WDB_STATIC_INCLUDE_DIR whitedb
        HINTS ${WDB_INCLUDEDIR} ${WDB_INCLUDE_DIRS})

find_library(WDB_STATIC_LIBRARY NAMES wgdb.a libwgdb.a
        HINTS ${WDB_LIBDIR} ${WDB_LIBRARY_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIETLY and REQUIRED arguments and set LIBNATS_STATIC_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(WDB_STATIC DEFAULT_MSG WDB_STATIC_LIBRARY WDB_STATIC_INCLUDE_DIR)

mark_as_advanced(WDB_STATIC_INCLUDE_DIR WDB_STATIC_LIBRARY )

set(WDB_STATIC_LIBRARIES ${WDB_STATIC_LIBRARY} )
set(WDB_STATIC_INCLUDE_DIRS ${WDB_STATIC_INCLUDE_DIR} )
