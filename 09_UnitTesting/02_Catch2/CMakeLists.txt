# Typical Manual way to build cmake project
#   0.) Create Source and CMakeFile
#   1.) mkdir build
#   2.) cd build
#   3.) cmake ..   -  Configure the Project -> Generte the Build Files (default Makefiles)
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
set(CMAKE_CXX_STANDARD_REQUIRED ON) #required a compiler that has fully implmented the C++ standard 17
set(CMAKE_CXX_EXTENSIONS        OFF) #turn off GCC C++ extensions
#. Add our customs cmake module, to cmake search path
set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake/")
# Custom Variable names
#--------------------------
# varialbe name      value
#         v            v
set(MY_LIB_NAME "MyLibrary") # quotation marks are optional, cmake can do automatic type
set(MY_EXECUTABLE_NAME MyExecutable)

# User defined CMake Options
# -------------------------------
# with options think boolean
#       option_varialbe name        optional description              default value
option(IS_COMPILE_EXECUTABLE_SET "Whether to compile the executable" OFF)

#. Load and run our custom cmake module 
include(AddGitSubmodule)
#. Load and run cmake built-in module FetchContent
include(FetchContent)
#. Load and run custom target to build documentation 
include(Docs)

#. call cmake built-in module functions
#. Clone the github Cmake project nlohman_json non-recursively
#. Note: Project has to be a cmake project
FetchContent_Declare(
    nlohman_json
    GIT_REPOSITORY https://github.com/nlohmann/json.git
    GIT_TAG v3.11.2
    GIT_SHALLOW TRUE
)
#. Load the project into our build project
FetchContent_MakeAvailable(nlohman_json)

FetchContent_Declare(
    fmt_dif_name
    GIT_REPOSITORY https://github.com/fmtlib/fmt
    GIT_TAG 10.2.1
    GIT_SHALLOW TRUE)
FetchContent_MakeAvailable(fmt_dif_name)

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

FetchContent_Declare(
    Catch2
    GIT_REPOSITORY https://github.com/catchorg/Catch2
    GIT_TAG v2.13.9
    GIT_SHALLOW TRUE)
FetchContent_MakeAvailable(Catch2)

#. Order of listing will cause a build issue if add_subdirectory(inc) comes before src. 
# it customary to list the subdirectory 
# as per the order the target are build. Depedencies first
#. in inc folder we are using the target, so the target MyLibary must be defined 
# first, that's why add_subdirectory(inc) is 2nd.
#. If the target is not defined first, how can we use the target? so the Order here matter
add_subdirectory(src)
add_subdirectory(inc)
add_subdirectory(config)
add_subdirectory(tests)

if (IS_COMPILE_EXECUTABLE_SET)
    add_subdirectory(app)
else()
    message("Building the project without creating the executable")
endif()
