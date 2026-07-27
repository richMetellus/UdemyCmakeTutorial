#[[
Description: This cmake user-defined function allows the user to enable
    compiler sanitizers.
]]
function(crs_add_sanitizer_flags)
    if (NOT ${CRS_ENABLE_SANITIZE_ADDR} AND NOT ${CRS_ENABLE_SANITIZE_UNDEF})
        message(STATUS "Sanitizers deactivated.")
        return()
    endif()

    if(CMAKE_CXX_COMPILER_ID MATCHES "Clang" OR CMAKE_CXX_COMPILER_ID MATCHES "GNU")
        add_compile_options("-fno-omit-frame-pointer") # add the compiler flags for every target
        add_link_options("-fno-omit-frame-pointer") # give the same flag to the linker

        if(${CRS_ENABLE_SANITIZE_ADDR})
            add_compile_options("-fsanitize=address")
            add_link_options("-fsanitize=address")
        endif()

        if(${CRS_ENABLE_SANITIZE_UNDEF})
            add_compile_options("-fsanitize=undefined")
            add_link_options("-fsanitize=undefined")
        endif()
    elseif(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
        if(${CRS_ENABLE_SANITIZE_ADDR})
            add_compile_options("/fsanitize=address")
        endif()

        if(${CRS_ENABLE_SANITIZE_UNDEF})
            message(STATUS "Undefined sanitizer not impl. for MSVC!")
        endif()
    else()
        message(STATUS "Sanitizer not supported in this environment!")
    endif()
endfunction(crs_add_sanitizer_flags)

