# - Try to find LibXml2
# Once done this will define
#  FARMHASH_STATIC_FOUND - System has LibXml2
#  FARMHASH_STATIC_INCLUDE_DIRS - The LibXml2 include directories
#  FARMHASH_STATIC_LIBRARIES - The libraries needed to use LibXml2
#  FARMHASH_STATIC_DEFINITIONS - Compiler switches required for using LibXml2

set(FARMHASH_STATIC_DEFINITIONS ${FARMHASH_CFLAGS})

find_path(FARMHASH_STATIC_INCLUDE_DIR whitedb
        HINTS 
            ${FARMHASH_INCLUDEDIR}
            ${FARMHASH_INCLUDE_DIRS}
            "${BSVENDOR_DIR}/include"
            "/usr/include"
            "/usr/local/include")

find_library(FARMHASH_STATIC_LIBRARY 
        NAMES farmhash.a libfarmhash.a
        HINTS 
            ${FARMHASH_LIBDIR}
            ${FARMHASH_LIBRARY_DIRS}
            "${BSVENDOR_DIR}/lib"
            "/usr/local/lib"
            "/usr/lib")

include(FindPackageHandleStandardArgs)
# handle the QUIETLY and REQUIRED arguments and set LIBNATS_STATIC_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(FARMHASH_STATIC DEFAULT_MSG FARMHASH_STATIC_LIBRARY FARMHASH_STATIC_INCLUDE_DIR)

mark_as_advanced(FARMHASH_STATIC_INCLUDE_DIR FARMHASH_STATIC_LIBRARY )

set(FARMHASH_STATIC_LIBRARIES ${FARMHASH_STATIC_LIBRARY} )
set(FARMHASH_STATIC_INCLUDE_DIRS ${FARMHASH_STATIC_INCLUDE_DIR} )
