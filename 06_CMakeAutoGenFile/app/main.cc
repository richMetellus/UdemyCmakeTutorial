#include <iostream>
#include <mylib.h>
#include <config_version.hpp>

int main()
{
    std::cout << "Project name: " << project_name << std::endl;
    std::cout << "Project version: " << project_version << '\n';
    print_hello_world();

    return 0;
}
