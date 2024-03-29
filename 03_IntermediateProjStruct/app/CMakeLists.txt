#          User defined name
#                  v
add_executable(MyExecutable main.cc) # compile the source files into an executable

target_link_libraries(MyExecutable PUBLIC MyLibrary) # link our library object file(s) ex mylib.o to the executable
