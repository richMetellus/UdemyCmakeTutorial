set(MY_LIB_SOURCES 
    "mylib.cc"
    ) # quotation marks are optional. new source filename will go a line under without comma, just space
 
add_library(${MY_LIB_NAME} STATIC ${MY_LIB_SOURCES}) # target is defined here
