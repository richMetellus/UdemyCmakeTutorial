# Typical Manual way to build cmake project
#   0.) Create Source and CMakeFile
#   1.) mkdir build
#   2.) cd build
#   3.) cmake ..   -  Configure the Project -> Generate the Build Files (default Makefiles)
#   4.) cmake --build . 
#   5.) ./app/MyExecutable

cmake_minimum_required(VERSION 3.22)

project(
    CppProjectTemplate 
    VERSION 1.0.0 
    LANGUAGES C CXX)


# Overriding CMake Built-in Variable 
#------------------------------------
set(CMAKE_CXX_STANDARD          17) #override the compiler default standard
set(CMAKE_CXX_STANDARD_REQUIRED ON) #required a compiler that has fully implemented the C++ standard 17
set(CMAKE_CXX_EXTENSIONS        OFF) #turn off GCC C++ extensions
#. Add our customs cmake module, to cmake search path
set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake/")
# Custom Variable names
#--------------------------
# variable name      value
#         v            v
set(MY_LIB_NAME "MyLibrary") # quotation marks are optional, cmake can do automatic type
set(MY_EXECUTABLE_NAME MyExecutable)

# User defined CMake Options
# -------------------------------
# with options think boolean
#       option_variable name        optional description              default value
option(IS_COMPILE_EXECUTABLE_SET "Whether to compile the executable" ON)
option(ENABLE_TESTING "Enable a Unit Testing Build" ON)
option(CRS_ENABLE_WARNINGS "Enable compiler warnings" ON) # This should always be enabled
option(CRS_ENABLE_WARNINGS_AS_ERRORS "Treat compiler warnings as errors" ON) # this option is up to you..too strict

option(CRS_ENABLE_SANITIZE_ADDR "Enable address sanitizer" ON)
option(CRS_ENABLE_SANITIZE_UNDEF "Enable sanitize undefined" ON)


#. Load and run our custom cmake module 
include(AddGitSubmodule)
#. Load and run cmake built-in module FetchContent
include(FetchContent)
#. Load and run custom target to build documentation 
include(Docs)

if(CRS_ENABLE_WARNINGS)
    include(CrsWarnings)
endif()

if(${CRS_ENABLE_SANITIZE_ADDR} OR ${CRS_ENABLE_SANITIZE_UNDEF})
    include(CrsSanitizers)
    crs_add_sanitizer_flags()
endif()

#. call cmake built-in module functions
#. Clone the github Cmake project nlohman_json non-recursively
#. Note: Project has to be a cmake project
FetchContent_Declare(
    nlohman_json
    GIT_REPOSITORY https://github.com/nlohmann/json.git
    GIT_TAG v3.11.3
    GIT_SHALLOW TRUE
)
#. Load the project into our build project
FetchContent_MakeAvailable(nlohman_json)

FetchContent_Declare(
    fmt
    GIT_REPOSITORY https://github.com/fmtlib/fmt
    GIT_TAG 9.1.0
    GIT_SHALLOW TRUE)
FetchContent_MakeAvailable(fmt)

FetchContent_Declare(
    spdlog
    GIT_REPOSITORY https://github.com/gabime/spdlog
    GIT_TAG v1.13.0
    GIT_SHALLOW TRUE)
FetchContent_MakeAvailable(spdlog)

FetchContent_Declare(
    cxxopts
    GIT_REPOSITORY https://github.com/jarro2783/cxxopts
    GIT_TAG v3.1.1
    GIT_SHALLOW TRUE)
FetchContent_MakeAvailable(cxxopts)

if(ENABLE_TESTING)
    FetchContent_Declare(
        Catch2
        GIT_REPOSITORY https://github.com/catchorg/Catch2
        GIT_TAG v3.5.3
        GIT_SHALLOW TRUE)
    FetchContent_MakeAvailable(Catch2)
    list(APPEND CMAKE_MODULE_PATH ${catch2_SOURCE_DIR}/extras)
endif()

#. Order of listing will cause a build issue if add_subdirectory(inc) comes before src. 
# it customary to list the subdirectory 
# as per the order the target are build. Dependencies first
#. in inc folder we are using the target, so the target MyLibrary must be defined 
# first, that's why add_subdirectory(inc) is 2nd.
#. If the target is not defined first, how can we use the target? so the Order here matter
add_subdirectory(src)
add_subdirectory(inc)
add_subdirectory(config)

if (IS_COMPILE_EXECUTABLE_SET)
    add_subdirectory(app)
else()
    message("Building the project without creating the executable")
endif()

if(ENABLE_TESTING)
    include(CTest)
    enable_testing()
    add_subdirectory(tests)
endif()
