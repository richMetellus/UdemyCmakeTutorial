#[[
Enable Interprocedural Optimization (IPO)/Link Time Optimization (LTO)
https://cmake.org/cmake/help/latest/module/CheckIPOSupported.html
require cmake 3.9 or above
]]
function(crs_target_enable_lto CRS_TARGET CRS_ENABLE)
    if(NOT ${CRS_ENABLE})
        message(STATUS "Not Enabling LTO!")
        return()
    endif()

    include(CheckIPOSupported) # include a pre-defined cmake module
    #[[
        In CheckIPOSupported.cmake there is a function check_ipo_supported,
        cmake will detect which compiler we are using and set the crs_result
    ]]
    check_ipo_supported(RESULT crs_result OUTPUT crs_output)

    if(crs_result)
        message(STATUS "IPO/LTO is supported for ${CRS_TARGET} target!")
        # This predefined cmake property, INTERPROCEDURAL_OPTIMIZATION, is set if LTO is supported by the compiler
        set_property(TARGET ${CRS_TARGET} PROPERTY INTERPROCEDURAL_OPTIMIZATION ${CRS_ENABLE})
    else()
        message(WARNING "IPO/LTO is not supported!")
    endif()
endfunction(crs_target_enable_lto)
