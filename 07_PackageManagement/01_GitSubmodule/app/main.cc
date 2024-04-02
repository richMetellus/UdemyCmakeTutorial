#include <iostream>
#include <mylib.h>
#include <config_version.hpp>
#include <nlohmann/json.hpp>

int main()
{
    std::cout << "Project name: " << project_name << std::endl;
    std::cout << "Project version: " << project_version << '\n';
    
    std::cout << "NLOHMANN JSON Lib Version:" << NLOHMANN_JSON_VERSION_MAJOR << "." 
              << NLOHMANN_JSON_VERSION_MINOR << "."
              << NLOHMANN_JSON_VERSION_PATCH << "\n";

    print_hello_world();

    return 0;
}
