#[[
Description: This cmake user-defined function allows the user to enable
    compiler sanitizers.
]]
function(crs_add_sanitizer_flags)
    if(NOT ${CRS_ENABLE_SANITIZE_ADDR} AND NOT ${CRS_ENABLE_SANITIZE_UNDEF})
        message(STATUS "Sanitizers deactivated.")
        return()
    endif()

    if(CMAKE_CXX_COMPILER_ID MATCHES "Clang" OR CMAKE_CXX_COMPILER_ID MATCHES
                                                "GNU")
        add_compile_options("-fno-omit-frame-pointer"
        )# add the compiler flags for every target
        add_link_options("-fno-omit-frame-pointer"
        )# give the same flag to the linker

        if(${CRS_ENABLE_SANITIZE_ADDR})
            message(STATUS "Activating Address Sanitizer")
            add_compile_options("-fsanitize=address")
            add_link_options("-fsanitize=address")
        endif()

        if(${CRS_ENABLE_SANITIZE_UNDEF})
            message(STATUS "Activating Undefined Sanitizer")
            add_compile_options("-fsanitize=undefined")
            add_link_options("-fsanitize=undefined")
        endif()
        if(CRS_ENABLE_SANITIZE_LEAK)
            add_compile_options("-fsanitize=leak")
            add_link_options("-fsanitize=leak")
        endif()

        if(CRS_ENABLE_SANITIZE_THREAD)
            if(CRS_ENABLE_SANITIZE_ADDR OR CRS_ENABLE_SANITIZE_LEAK)
                message(WARNING "thread does not work with: address and leak")
            endif()
            message(STATUS "Activating Thread Sanitizer")
            add_compile_options("-fsanitize=thread")
            add_link_options("-fsanitize=thread")
        endif()

    elseif(CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
        if(CRS_ENABLE_SANITIZE_ADDR)
            message(STATUS "Activating Address Sanitizer")
            add_compile_options("/fsanitize=address")
        endif()

        if(CRS_ENABLE_SANITIZE_UNDEF)
            message(STATUS "sanitize=undefined not avail. for MSVC")
        endif()

        if(CRS_ENABLE_SANITIZE_LEAK)
            message(STATUS "sanitize=leak not avail. for MSVC")
        endif()

        if(CRS_ENABLE_SANITIZE_THREAD)
            message(STATUS "sanitize=thread not avail. for MSVC")
        endif()
    else()
        message(WARNING "This sanitizer not supported in this environment")
        return()
    endif()
endfunction(crs_add_sanitizer_flags)
