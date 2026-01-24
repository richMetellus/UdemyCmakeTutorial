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