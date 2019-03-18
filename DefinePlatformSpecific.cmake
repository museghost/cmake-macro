# http://www.cmake.org/Wiki/CMake_Useful_Variables :
# CMAKE_BUILD_TYPE
#    Choose the type of build. CMake has default flags for these:
#
#    * None (CMAKE_C_FLAGS or CMAKE_CXX_FLAGS used)
#    * Debug (CMAKE_C_FLAGS_DEBUG or CMAKE_CXX_FLAGS_DEBUG)
#    * Release (CMAKE_C_FLAGS_RELEASE or CMAKE_CXX_FLAGS_RELEASE)
#    * RelWithDebInfo (CMAKE_C_FLAGS_RELWITHDEBINFO or CMAKE_CXX_FLAGS_RELWITHDEBINFO
#    * MinSizeRel (CMAKE_C_FLAGS_MINSIZEREL or CMAKE_CXX_FLAGS_MINSIZEREL)

# Setting CXX Flag /MD or /MT and POSTFIX values i.e MDd / MD / MTd / MT / d
#
# For visual studio the library naming is as following:
#  Dynamic libraries:
#   - AphroX.dll  for release library
#   - AphroXd.dll for debug library
#
#  Static libraries:
#   - AphroXmd.lib for /MD release build
#   - AphroXtmt.lib for /MT release build
#
#   - AphroXmdd.lib for /MD debug build
#   - AphroXmtd.lib for /MT debug build

if(MSVC)
    if(APHROC_MT)
        set(CompilerFlags
                CMAKE_CXX_FLAGS
                CMAKE_CXX_FLAGS_DEBUG
                CMAKE_CXX_FLAGS_RELEASE
                CMAKE_C_FLAGS
                CMAKE_C_FLAGS_DEBUG
                CMAKE_C_FLAGS_RELEASE
                )
        foreach(CompilerFlag ${CompilerFlags})
            string(REPLACE "/MD" "/MT" ${CompilerFlag} "${${CompilerFlag}}")
        endforeach()

        set(STATIC_POSTFIX "mt" CACHE STRING "Set static library postfix" FORCE)
    else(APHROC_MT)
        set(STATIC_POSTFIX "md" CACHE STRING "Set static library postfix" FORCE)
    endif(APHROC_MT)

    if (ENABLE_MSVC_MP)
        add_definitions(/MP)
    endif()

else(MSVC)
    # Other compilers then MSVC don't have a static STATIC_POSTFIX at the moment
    set(STATIC_POSTFIX "" CACHE STRING "Set static library postfix" FORCE)
    set(CMAKE_C_FLAGS_DEBUG   "${CMAKE_C_FLAGS_DEBUG}   -D_DEBUG")
    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -D_DEBUG")
endif(MSVC)

# Add a d postfix to the debug libraries
if(APHROC_STATIC)
    set(CMAKE_DEBUG_POSTFIX "${STATIC_POSTFIX}d" CACHE STRING "Set Debug library postfix" FORCE)
    set(CMAKE_RELEASE_POSTFIX "${STATIC_POSTFIX}" CACHE STRING "Set Release library postfix" FORCE)
    set(CMAKE_MINSIZEREL_POSTFIX "${STATIC_POSTFIX}" CACHE STRING "Set MinSizeRel library postfix" FORCE)
    set(CMAKE_RELWITHDEBINFO_POSTFIX "${STATIC_POSTFIX}" CACHE STRING "Set RelWithDebInfo library postfix" FORCE)
else(APHROC_STATIC)
    set(CMAKE_DEBUG_POSTFIX "d" CACHE STRING "Set Debug library postfix" FORCE)
    set(CMAKE_RELEASE_POSTFIX "" CACHE STRING "Set Release library postfix" FORCE)
    set(CMAKE_MINSIZEREL_POSTFIX "" CACHE STRING "Set MinSizeRel library postfix" FORCE)
    set(CMAKE_RELWITHDEBINFO_POSTFIX "" CACHE STRING "Set RelWithDebInfo library postfix" FORCE)
endif()


# OS Detection
include(CheckTypeSize)
find_package(Cygwin)

if(WIN32)
    add_definitions( -DUNICODE -D_UNICODE -D__LCC__)  #__LCC__ define used by MySQL.h
    message(STATUS "Compiler WIN32 definitions added - UNICODE added")
endif(WIN32)

if (CYGWIN)
    add_definitions(-DAPHROC_NO_FPENVIRONMENT -DAPHROC_NO_WSTRING)
    add_definitions(-D_XOPEN_SOURCE=500 -D__BSD_VISIBLE)
    message(STATUS "Compiler CYGWIN definitions added")
else (CYGWIN)
    if (UNIX AND NOT ANDROID )
        # Standard 'must be' defines
        if (APPLE)
            add_definitions( -DAPHROC_HAVE_IPv6 -DAPHROC_NO_STAT64)
            set(SYSLIBS  dl)
        else (APPLE)
            add_definitions( -D_REENTRANT -D_THREAD_SAFE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 )
            if (QNX)
                add_definitions( -DAPHROC_HAVE_FD_POLL)
                set(SYSLIBS  m socket)
            elseif(${CMAKE_SYSTEM} MATCHES "AIX")
                add_definitions(-D__IBMCPP_TR1__)
            else ()
                add_definitions( -D_XOPEN_SOURCE=500 -DAPHROC_HAVE_FD_EPOLL)
                set(SYSLIBS  pthread rt -Wl,--no-as-needed -ldl)
            endif ()
        endif (APPLE)
    endif(UNIX AND NOT ANDROID )
endif (CYGWIN)

if (CMAKE_SYSTEM MATCHES "SunOS")
    # Standard 'must be' defines
    add_definitions( -D_XOPEN_SOURCE=500 -D_REENTRANT -D_THREAD_SAFE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 )
    set(SYSLIBS  pthread socket xnet nsl resolv rt dl)
endif(CMAKE_SYSTEM MATCHES "SunOS")

if (CMAKE_COMPILER_IS_MINGW)
    message(STATUS "Compiler MINGW definitions added")
    add_definitions(-DWC_NO_BEST_FIT_CHARS=0x400  -DPOCO_WIN32_UTF8)
    add_definitions(-D_WIN32 -DWIN32 -DWINNT -D_WINNT -DMINGW32 -DWINVER=0x0600 -D_WIN32_WINNT=0x0600 -DODBCVER=0x0300 -DAPHROC_THREAD_STACK_SIZE)
    #message(STATUS "lto option added for reducing linking time")
    #string(APPEND CMAKE_CXX_FLAGS " -flto  -v -Wl,-v -save-temps")
    #string(APPEND CMAKE_C_FLAGS " -flto  -v -Wl,-v -save-temps")
    #string(APPEND CMAKE_EXE_LINKER_FLAGS " -flto=2")
    #SET(CMAKE_AR "gcc-ar")
    #set(CMAKE_RANLIB "gcc-ranlib")
    #SET(CMAKE_C_ARCHIVE_CREATE "<CMAKE_AR> qcs <TARGET> <LINK_FLAGS> <OBJECTS>")
    #SET(CMAKE_C_ARCHIVE_FINISH  true)
    #SET(CMAKE_CXX_ARCHIVE_CREATE "<CMAKE_AR> qcs <TARGET> <LINK_FLAGS> <OBJECTS>")
    #SET(CMAKE_CXX_ARCHIVE_FINISH true)
endif (CMAKE_COMPILER_IS_MINGW)

# SunPro C++
if (${CMAKE_CXX_COMPILER_ID} MATCHES "SunPro")
    add_definitions( -D_BSD_SOURCE -library=stlport4)
endif (${CMAKE_CXX_COMPILER_ID} MATCHES "SunPro")

# iOS
if (IOS)
    add_definitions( -DAPHROC_HAVE_IPv6 -DAPHROC_NO_FPENVIRONMENT -DAPHROC_NO_STAT64 -DAPHROC_NO_SHAREDLIBS -DAPHROC_NO_NET_IFTYPES )
endif(IOS)

#Android
if (ANDROID)
    add_definitions( -DAPHROC_ANDROID -DAPHROC_NO_FPENVIRONMENT -DAPHROC_NO_WSTRING -DAPHROC_NO_SHAREDMEMORY )
endif(ANDROID)

# IBM XLC for AIX
if ((${CMAKE_CXX_COMPILER_ID} MATCHES "XL") AND (${CMAKE_SYSTEM} MATCHES "AIX"))
    set(WARNINGS_FLAGS "-qsuppress=1540-0198 -qsuppress=1540-1628 -qsuppress=1540-0095 -qsuppress=1500-030")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -qlanglvl=extended0x -qlanglvl=noconstexpr -qlanglvl=newexcp ${WARNINGS_FLAGS}")
endif()