#[[
Description: This cmake user-defined function allows the user to enable compiler warnings 
             as errors.
]]
function(crs_target_set_warnings CRS_TARGET CRS_ENABLE CRS_ENABLE_AS_ERRORS)
    # check if the user if the user does not want to enable any warnings
    if (NOT ${CRS_ENABLED})
        message(STATUS "Warnings are Disabled for: ${CRS_TARGET}")
        return()
    endif()

    # set a collection of useful warnings of popular compilers
    # https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html
    set(CRS_MSVC_WARNINGS
        /W4
        /permissive-)

    set(CRS_CLANG_WARNINGS
        -Wall
        -Wextra
        -Wpedantic)
    # GCC and Clang use similar Warning options
    set(CRS_GCC_WARNINGS
        ${CRS_CLANG_WARNINGS})

    if(${CRS_ENABLE_AS_ERRORS})
        set(CRS_MSVC_WARNINGS ${CRS_MSVC_WARNINGS} /WX)
        set(CRS_CLANG_WARNINGS ${CRS_CLANG_WARNINGS} -Werror)
        set(CRS_GCC_WARNINGS ${CRS_GCC_WARNINGS} -Werror)
    endif()

    # Check which compiler the user is using and set the warnings
    if (CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
        set(CRS_WARNINGS ${CRS_MSVC_WARNINGS})
    elseif(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
        set(CRS_WARNINGS ${CRS_CLANG_WARNINGS})
    elseif(CMAKE_CXX_COMPILER_ID MATCHES "GNU")
        set(CRS_WARNINGS ${CRS_GCC_WARNINGS})
        message(STATUS "GNU detected ${CRS_WARNINGS}")
    endif()

    target_compile_options(${CRS_TARGET} PRIVATE ${CRS_WARNINGS})
    message(STATUS "Compile Options: ${CRS_WARNINGS}")

endfunction(crs_target_set_warnings)
