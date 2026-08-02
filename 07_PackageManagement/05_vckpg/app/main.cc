#include <iostream>
#include <nlohmann/json.hpp>
#include <cxxopts.hpp>
#include <fmt/format.h>
#include <spdlog/spdlog.h>

#include <mylib.h>
#include <config_version.hpp>

int main()
{
    std::cout << "Project name: " << project_name << std::endl;
    std::cout << "Project version: " << project_version << '\n';
    
    // int i; // unused variable

    // uncommented the block below for verifying sanitizers
    // int x[2] = {0}; // define an array of size 2; x is set
    // x[1] = 0xDEAFD012;
    // std::cout << "address of x = " << &x << "; x[0]: " << x[0] << ", x[1]: " << x[1] << '\n'; // x is used/read here to avoid compiler warnings.
    // x[2] = 0xDEADBEEF; // add value outside the array bounds => runtime error, undefined behavior
    
    std::cout << "NLOHMANN JSON Lib Version:" << NLOHMANN_JSON_VERSION_MAJOR << "." 
              << NLOHMANN_JSON_VERSION_MINOR << "."
              << NLOHMANN_JSON_VERSION_PATCH << "\n";

    std::cout << "FMT: " << FMT_VERSION << "\n";

    std::cout << "CXXOPTS: " << CXXOPTS__VERSION_MAJOR << "." 
              << CXXOPTS__VERSION_MINOR << "." 
              << CXXOPTS__VERSION_PATCH
              << "\n";

    std::cout << "SPDLOG: " << SPDLOG_VER_MAJOR << "." 
              << SPDLOG_VER_MINOR << "." 
              << SPDLOG_VER_PATCH << "\n";

    print_hello_world();

    return 0;
}
