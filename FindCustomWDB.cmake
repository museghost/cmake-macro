function(find_custom_wdb _NAME _VER)
    include(FindCustomLibrary)

    # ${_NAME_UPPER}, ${_NAME_LOWER} available
    set_custom_lib_vars(${_NAME})

    set_min_library_version(${_NAME_UPPER} ${_VER})

    find_custom_library(${_NAME_UPPER} whitedb ${${_NAME_UPPER}_CUSTOM_MIN_VER})

endfunction()
