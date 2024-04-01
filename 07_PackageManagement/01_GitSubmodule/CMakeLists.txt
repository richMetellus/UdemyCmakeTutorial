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

#. Order of listing will cause a build issue if add_subdirectory(inc) comes before src. 
# it customary to list the subdirectory 
# as per the order the target are build. Depedencies first
#. in inc folder we are using the target, so the target MyLibary must be defined 
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
