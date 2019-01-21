# - Try to find LibXml2
# Once done this will define
#  CURLPP_STATIC_FOUND - System has LibXml2
#  CURLPP_STATIC_INCLUDE_DIRS - The LibXml2 include directories
#  CURLPP_STATIC_LIBRARIES - The libraries needed to use LibXml2
#  CURLPP_STATIC_DEFINITIONS - Compiler switches required for using LibXml2

set(CURLPP_STATIC_DEFINITIONS ${CURLPP_CFLAGS})

find_path(CURLPP_STATIC_INCLUDE_DIR curlpp
        HINTS
            ${CURLPP_INCLUDEDIR}
            ${CURLPP_INCLUDE_DIRS}
            "${BSVENDOR_DIR}/include"
            "/usr/include"
            "/usr/local/include")

find_library(CURLPP_STATIC_LIBRARY NAMES curlpp.a libcurlpp.a
        HINTS
            ${CURLPP_LIBDIR}
            ${CURLPP_LIBRARY_DIRS}
            "${BSVENDOR_DIR}/lib"
            "/usr/local/lib"
            "/usr/lib")

include(FindPackageHandleStandardArgs)
# handle the QUIETLY and REQUIRED arguments and set LIBNATS_STATIC_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(CURLPP_STATIC DEFAULT_MSG CURLPP_STATIC_LIBRARY CURLPP_STATIC_INCLUDE_DIR)

mark_as_advanced(CURLPP_STATIC_INCLUDE_DIR CURLPP_STATIC_LIBRARY )

set(CURLPP_STATIC_LIBRARIES ${CURLPP_STATIC_LIBRARY} )
set(CURLPP_STATIC_INCLUDE_DIRS ${CURLPP_STATIC_INCLUDE_DIR} )
