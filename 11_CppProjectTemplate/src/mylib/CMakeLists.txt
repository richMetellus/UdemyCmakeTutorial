set(MY_LIB_SOURCES 
    "mylib.cc"
    ) # quotation marks are optional. new source filename will go a line under without comma, just space

add_library(${MY_LIB_NAME} STATIC ${MY_LIB_SOURCES}) # target is defined here

target_link_libraries(${MY_LIB_NAME}  
    PRIVATE 
        fmt::fmt
        spdlog::spdlog
        cxxopts::cxxopts)

if (${CRS_ENABLE_WARNINGS})
    crs_target_set_warnings(
        TARGET
        ${MY_LIB_NAME}
        ENABLE
        ${CRS_ENABLE_WARNINGS}
        AS_ERRORS
        ${CRS_ENABLE_WARNINGS_AS_ERRORS}
    )
endif()

# Enable print_hello_world block
target_compile_definitions(${MY_LIB_NAME} PUBLIC PRINTER_ACTIVE)

if (CRS_ENABLE_LTO)
    crs_target_enable_lto(
        CRS_TARGET
        ${MY_LIB_NAME}
        CRS_ENABLE
        ${CRS_ENABLE_LTO}
    )
endif()
