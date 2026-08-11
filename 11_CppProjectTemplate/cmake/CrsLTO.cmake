#[[
Enable Interprocedural Optimization (IPO)/Link Time Optimization (LTO)
https://cmake.org/cmake/help/latest/module/CheckIPOSupported.html
require cmake 3.9 or above
]]
function(crs_target_enable_lto)
    set(oneValueArgs CRS_TARGET CRS_ENABLE)
    cmake_parse_arguments(
        CRS_LTO
        "${options}"
        "${oneValueArgs}"
        "${multiValueArgs}"
        ${ARGN})

    include(CheckIPOSupported) # include a pre-defined cmake module
    #[[
        In CheckIPOSupported.cmake there is a function check_ipo_supported,
        cmake will detect which compiler we are using and set the result in
        the variable crs_result
    ]]
    check_ipo_supported(RESULT crs_result OUTPUT crs_output)

    if(crs_result)
        message(STATUS "IPO/LTO is supported: ${CRS_LTO_CRS_TARGET}")
        # This predefined cmake property, INTERPROCEDURAL_OPTIMIZATION, is set if LTO is supported by the compiler
        set_property(
            TARGET ${CRS_LTO_CRS_TARGET} PROPERTY INTERPROCEDURAL_OPTIMIZATION
                                                  ${CRS_LTO_CRS_TARGET})
    else()
        message(WARNING "IPO/LTO is not supported: ${CRS_LTO_CRS_TARGET}")
    endif()
endfunction()
