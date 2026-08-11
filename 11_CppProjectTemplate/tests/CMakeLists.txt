include(Catch) # to provide additional test features for CTest

set(TEST_MAIN "unit_tests")
set(TEST_SOURCES "main.cc")
set(TEST_INCLUDES "./")

add_executable(${TEST_MAIN} ${TEST_SOURCES})
target_include_directories(${TEST_MAIN} PUBLIC ${TEST_INCLUDES})
target_link_libraries(${TEST_MAIN} PUBLIC ${MY_LIB_NAME} Catch2::Catch2WithMain)

# Adding the line below indicate to CTest the executable is not a regular one,
# but an executable for test units. catch_discover_tests function is provided by
# Catch.cmake module
catch_discover_tests(${TEST_MAIN})
