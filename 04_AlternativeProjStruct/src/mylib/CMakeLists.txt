#. Order of listing will cause a build issue if add_subdirectory(inc) comes before src. 
# it customary to list the subdirectory 
# as per the order the target are build. Depedencies first
#. in inc folder we are using the target, so the target MyLibary must be defined 
# first, that's why add_subdirectory(inc) is 2nd.
#. If the target is not defined first, how can we use the target? so the Order here matter.
#. MyLibrary target is define in mylib/src/CMakeLists.txt
add_subdirectory(src)
add_subdirectory(inc)

