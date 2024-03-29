# Typical Manual way to build cmake project
#   0.) Create Source and CMakeFile
#   1.) mkdir build
#   2.) cd build
#   3.) cmake ..   -  Configure the Project -> Generte the Build Files (default Makefiles)
#   4.) cmake --build . 
#   5.) ./MyExecutable

cmake_minimum_required(VERSION 3.22)

project(
    CppProjectTemplate 
    VERSION 1.0.0 
    LANGUAGES C CXX)

add_library(MyLibrary STATIC src/mylib.cc)
#          User defined name
#                  v
add_executable(MyExecutable app/main.cc) # compile the source files into an executable

target_link_libraries(MyExecutable PUBLIC MyLibrary) # link our library object file(s) ex mylib.o to the executable
