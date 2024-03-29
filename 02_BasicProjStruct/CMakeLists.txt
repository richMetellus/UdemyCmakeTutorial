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

#          User defined name
#                  v
add_executable(MyExecutable main.cc mylib.cc) # compile the source files into an executable
