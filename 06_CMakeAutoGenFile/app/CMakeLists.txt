#          User defined name
#                  v
add_executable(${MY_EXECUTABLE_NAME} main.cc) # compile the source files into an executable
target_link_libraries(${MY_EXECUTABLE_NAME} PUBLIC ${MY_LIB_NAME}) # link our library object file(s) ex mylib.o to the executable
