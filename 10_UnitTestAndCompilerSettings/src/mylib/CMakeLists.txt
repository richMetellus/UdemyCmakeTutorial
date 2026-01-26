set(MY_LIB_SOURCES 
    "mylib.cc"
    ) # quotation marks are optional. new source filename will go a line under without comma, just space

add_library(${MY_LIB_NAME} STATIC ${MY_LIB_SOURCES}) # target is defined here

target_link_libraries(${MY_LIB_NAME}  PUBLIC 
    fmt::fmt
    spdlog::spdlog
    cxxopts::cxxopts)

if (${CRS_ENABLE_WARNINGS})
    crs_target_set_warnings(
        ${MY_LIB_NAME}
        ${CRS_ENABLE_WARNINGS}
        ${CRS_ENABLE_WARNINGS_AS_ERRORS}
    )
endif()

# Enable print_hello_world block
target_compile_definitions(${MY_LIB_NAME} PUBLIC PRINTER_ACTIVE)

if (CRS_ENABLE_LTO)
    crs_target_enable_lto(
        ${MY_LIB_NAME}
        ${CRS_ENABLE_LTO}
    )
endif()

#[[
using MSVC compiler kit.
At configuration phase, Cmake does not know the build type,
so this block is skipped.
]]
if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    target_compile_options(${MY_LIB_NAME} PUBLIC "/WX") # make PUBLIC since the error will come from main
endif()