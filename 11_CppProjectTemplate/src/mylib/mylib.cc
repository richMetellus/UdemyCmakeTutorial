#include <iostream>
#include <cstdint>
#include "mylib.h"

#ifdef PRINTER_ACTIVE
/**
 * @brief Prints out Hello World! to the console
 * 
 */
void print_hello_world()
{
    std::cout << "Hello World!\n";
    int *x = new int[42];
}
#endif

std::uint32_t factorial(std::uint32_t number)
{
  return number <= 1 ? 1 : factorial(number - 1) * number;
}
