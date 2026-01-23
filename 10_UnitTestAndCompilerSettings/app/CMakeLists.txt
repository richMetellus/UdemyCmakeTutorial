set(EXE_SOURCES
    "main.cc")
set(EXE_INCLUDES
    "./")

#          User defined name
#                  v
add_executable(${MY_EXECUTABLE_NAME} ${EXE_SOURCES}) # compile the source files into an executable
target_include_directories(${EXECUTABLE_NAME} PUBLIC
    ${EXE_INCLUDES})
target_link_libraries(${MY_EXECUTABLE_NAME} PUBLIC  
    ${MY_LIB_NAME}
    nlohmann_json # link our library object file(s) ex mylib.o to the executable
    fmt::fmt
    spdlog::spdlog
    cxxopts::cxxopts)
