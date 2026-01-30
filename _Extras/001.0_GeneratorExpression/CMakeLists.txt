cmake_minimum_required(VERSION 3.22)

project(
    LibExample
    VERSION 1.0.0
    LANGUAGES C CXX)

set(LIBRARY_NAME LibExample)

add_library(${LIBRARY_NAME} STATIC src/lib.cc)
target_include_directories(${LIBRARY_NAME} PUBLIC inc/)

#[[
checks for the compiler ID and the build type and add flags. These type of 
check don usually works for multi-configuration generators like Visual Studio 
Xcode, you can instead combine these two if statements, which
are just two logical expressions, into one generator expression.
]]

#[[

if(CMAKE_CXX_COMPILER_ID MATCHES "Clang" OR CMAKE_CXX_COMPILER_ID MATCHES "GNU")
    if(CMAKE_BUILD_TYPE STREQUAL "Debug")
        add_compile_options("-Wall")
    else()
        add_compile_options("-Wall -Werror")
    endif()
endif()

if(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
    if(CMAKE_BUILD_TYPE STREQUAL "Debug")
        add_compile_options("/W4")
    else()
        add_compile_options("/W4 /WX")
    endif()
endif()
]]

#[[
Generators Expression can get very messy to read. And this very weird syntax to be honest.
So I would suggest to only use it when you want to ask for the CMake build type.
]]
target_compile_options(
    ${LIBRARY_NAME}
    PRIVATE
        $<$<AND:$<OR:$<CXX_COMPILER_ID:Clang>,$<CXX_COMPILER_ID:GNU>>,$<CONFIG:Debug>>:-Wall>
        $<$<AND:$<OR:$<CXX_COMPILER_ID:Clang>,$<CXX_COMPILER_ID:GNU>>,$<CONFIG:Release>>:-Wall -Werror>
)

target_compile_options(
    ${LIBRARY_NAME}
    PRIVATE
        $<$<CXX_COMPILER_ID:MSVC>:$<$<CONFIG:Debug>:/W4>>
        $<$<CXX_COMPILER_ID:MSVC>:$<$<CONFIG:Release>:/W4 /WX>>

)

get_target_property(RESULT ${LIBRARY_NAME} COMPILE_OPTIONS)
message("-- Target compiler flags are ${RESULT}")