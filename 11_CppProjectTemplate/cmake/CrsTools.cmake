function(crs_add_cmake_format_target)
    if(NOT ${CRS_ENABLE_CMAKE_FORMAT})
        return()
    endif()
    set(CRS_ROOT_CMAKE_FILES "${CMAKE_SOURCE_DIR}/CMakeLists.txt")
    file(GLOB_RECURSE CRS_CMAKE_FILES_TXT "*/CMakeLists.txt")
    file(GLOB_RECURSE CRS_CMAKE_FILES_C "cmake/*.cmake")
    list(
        FILTER
        CRS_CMAKE_FILES_TXT
        EXCLUDE
        REGEX
        "${CMAKE_SOURCE_DIR}/(build|external)/.*")
    set(CRS_CMAKE_FILES ${CRS_ROOT_CMAKE_FILES} ${CRS_CMAKE_FILES_TXT} ${CRS_CMAKE_FILES_C})
    find_program(CRS_CMAKE_FORMAT cmake-format)
    if(CRS_CMAKE_FORMAT)
        message(STATUS "Added Cmake Format")
        set(CRS_FORMATTING_COMMANDS)
        foreach(crs_cmake_file ${CRS_CMAKE_FILES})
            list(
                APPEND
                CRS_FORMATTING_COMMANDS
                COMMAND
                cmake-format
                -c
                ${CMAKE_SOURCE_DIR}/.cmake-format.yaml
                -i
                ${crs_cmake_file})
        endforeach()
        add_custom_target(
            crs_run_cmake_format
            COMMAND ${CRS_FORMATTING_COMMANDS}
            WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})
    else()
        message(WARNING "CRS_CMAKE_FORMAT NOT FOUND")
    endif()
endfunction()

function(crs_add_clang_tidy_to_target crs_target)
    get_target_property(CRS_TARGET_SOURCES ${crs_target} SOURCES)
    list(
        FILTER
        CRS_TARGET_SOURCES
        INCLUDE
        REGEX
        ".*.(cc|h|cpp|hpp)")

    find_package(Python3 COMPONENTS Interpreter)
    if(NOT ${Python_FOUND})
        message(WARNING "Python3 needed for Clang-Tidy")
        return()
    endif()

    find_program(CRS_CLANGTIDY_FOUND clang-tidy)
    if(CRS_CLANGTIDY_FOUND)
        if(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
            message(STATUS "Added MSVC ClangTidy (VS GUI only) for: ${crs_target}")
            set_target_properties(
                ${crs_target} PROPERTIES VS_GLOBAL_EnableMicrosoftCodeAnalysis
                                     false)
            set_target_properties(
                ${crs_target} PROPERTIES VS_GLOBAL_EnableClangTidyCodeAnalysis true)
        else()
            message(STATUS "Added Clang Tidy for Target: ${crs_target}")
            add_custom_target(
                ${crs_target}_clangtidy
                COMMAND
                    ${Python3_EXECUTABLE}
                    ${CMAKE_SOURCE_DIR}/tools/run-clang-tidy.py
                    ${CRS_TARGET_SOURCES}
                    -config-file=${CMAKE_SOURCE_DIR}/.clang-tidy
                    -extra-arg-before=-std=${CMAKE_CXX_STANDARD}
                    -header-filter="\(src|app\)\/*.\(h|hpp\)"
                    -p=${CMAKE_BINARY_DIR}
                WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
                USES_TERMINAL)
        endif()
    else()
        message(WARNING "Clang-tidy NOT FOUND")
    endif()
endfunction()
