# - Try to find LibXml2
# Once done this will define
#  BENCHMARK_STATIC_FOUND - System has LibXml2
#  BENCHMARK_STATIC_INCLUDE_DIRS - The LibXml2 include directories
#  BENCHMARK_STATIC_LIBRARIES - The libraries needed to use LibXml2
#  BENCHMARK_STATIC_DEFINITIONS - Compiler switches required for using LibXml2

set(BENCHMARK_STATIC_DEFINITIONS ${WDB_CFLAGS_OTHER})

find_path(BENCHMARK_STATIC_INCLUDE_DIR benchmark
        HINTS 
            "${BSVENDOR_DIR}/include"
            "/usr/include"
            "/usr/local/include")

find_library(BENCHMARK_STATIC_LIBRARY 
        NAMES benchmark.a libbenchmark.a
        HINTS 
            "${BSVENDOR_DIR}/lib"
            "/usr/local/lib"
            "/usr/lib")

include(FindPackageHandleStandardArgs)
# handle the QUIETLY and REQUIRED arguments and set LIBNATS_STATIC_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(BENCHMARK_STATIC DEFAULT_MSG BENCHMARK_STATIC_LIBRARY BENCHMARK_STATIC_INCLUDE_DIR)

mark_as_advanced(BENCHMARK_STATIC_INCLUDE_DIR BENCHMARK_STATIC_LIBRARY )

set(BENCHMARK_STATIC_LIBRARIES ${BENCHMARK_STATIC_LIBRARY} )
set(BENCHMARK_STATIC_INCLUDE_DIRS ${BENCHMARK_STATIC_INCLUDE_DIR} )
