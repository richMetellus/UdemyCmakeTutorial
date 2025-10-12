function(add_git_submodule relative_dir)
    # use cmake function to check if Git exist on user's machine, else error out
    find_package(Git REQUIRED)

    #. Required full directory for this to work
    set(FULL_DIR ${CMAKE_SOURCE_DIR}/${relative_dir})

    #. Check if the submodule is a cmake project. use full directory path for it to work. 
    if (NOT EXISTS ${FULL_DIR}/CMakeLists.txt)
        #. call the git process to init the submodule. find_package(Git REQUIRED)
        # will set the varialbe ${GIT_EXECUTABLE}
        execute_process(COMMAND ${GIT_EXECUTABLE}
            submodule update --init --recursive -- ${relative_dir}
            WORKING_DIRECTORY ${PROJECT_SOURCE_DIR})
    endif()

    #. Verify the directory is a cmake project
    if (EXISTS ${FULL_DIR}/CMakeLists.txt)
        message("Submodule is CMake Project: ${FULL_DIR}/CMakeLists.txt")
        add_subdirectory(${FULL_DIR})
    else()
        message("Submodule is NO CMake Project: ${FULL_DIR}")
    endif()
endfunction(add_git_submodule)
