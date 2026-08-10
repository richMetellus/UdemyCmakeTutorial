set(EXE_SOURCES
    "main.cc")
set(EXE_INCLUDES
    "./")

#          User defined name
#                  v
add_executable(${MY_EXECUTABLE_NAME} ${EXE_SOURCES}) # compile the source files into an executable


target_include_directories(${MY_EXECUTABLE_NAME} PUBLIC
    ${EXE_INCLUDES})
target_link_libraries(${MY_EXECUTABLE_NAME} PUBLIC  
    ${MY_LIB_NAME}
    nlohmann_json::nlohmann_json # link our library object file(s) ex mylib.o to the executable
    fmt::fmt
    spdlog::spdlog
    cxxopts::cxxopts)

if (${CRS_ENABLE_WARNINGS})
    crs_target_set_warnings(
        TARGET
        ${MY_EXECUTABLE_NAME}
        ENABLE
        ${CRS_ENABLE_WARNINGS}
        AS_ERRORS
        ${CRS_ENABLE_WARNINGS_AS_ERRORS}
    )
endif()

if (CRS_ENABLE_LTO)
    crs_target_enable_lto(
        CRS_TARGET
        ${MY_EXECUTABLE_NAME}
        CRS_ENABLE
        ${CRS_ENABLE_LTO}
    )
endif()


if(${CRS_ENABLE_CLANG_TIDY})
    crs_add_clang_tidy_to_target(${MY_EXECUTABLE_NAME})
endif()
