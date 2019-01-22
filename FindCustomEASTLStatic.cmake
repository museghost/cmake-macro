# - Try to find LibXml2
# Once done this will define
#  EASTL_STATIC_FOUND - System has LibXml2
#  EASTL_STATIC_INCLUDE_DIRS - The LibXml2 include directories
#  EASTL_STATIC_LIBRARIES - The libraries needed to use LibXml2
#  EASTL_STATIC_DEFINITIONS - Compiler switches required for using LibXml2

set(EASTL_STATIC_DEFINITIONS ${EASTL_CFLAGS})

find_path(EASTL_STATIC_INCLUDE_DIR whitedb
        HINTS 
            ${EASTL_INCLUDEDIR}
            ${EASTL_INCLUDE_DIRS}
            "${BSVENDOR_DIR}/include"
            "/usr/include"
            "/usr/local/include")

find_library(EASTL_STATIC_LIBRARY 
        NAMES EASTL.a libEASTL.a
        HINTS 
            ${EASTL_LIBDIR}
            ${EASTL_LIBRARY_DIRS}
            "${BSVENDOR_DIR}/lib"
            "/usr/local/lib"
            "/usr/lib")

include(FindPackageHandleStandardArgs)
# handle the QUIETLY and REQUIRED arguments and set LIBNATS_STATIC_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(EASTL_STATIC DEFAULT_MSG EASTL_STATIC_LIBRARY EASTL_STATIC_INCLUDE_DIR)

mark_as_advanced(EASTL_STATIC_INCLUDE_DIR EASTL_STATIC_LIBRARY )

set(EASTL_STATIC_LIBRARIES ${EASTL_STATIC_LIBRARY} )
set(EASTL_STATIC_INCLUDE_DIRS ${EASTL_STATIC_INCLUDE_DIR} )
