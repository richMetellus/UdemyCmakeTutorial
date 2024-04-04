#include <iostream>
#include <cstdint>
#include "mylib.h"

/**
 * @brief Prints out Hello World! to the console
 * 
 */
void print_hello_world()
{
    std::cout << "Hello World!\n";
}

std::uint32_t Factorial(std::uint32_t number)
{
  return number <= 1 ? number : Factorial(number - 1) * number;
}
