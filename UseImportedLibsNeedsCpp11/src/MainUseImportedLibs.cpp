#include <iostream>
#include "UseImportedLibs.hpp"

int main()
{
    Code2::UseImportedLibs::UseLibrary();

#ifdef USE_IMPORTED_LIBS
    std::cout << "USE_IMPORTED_LIBS is ON\n";
#else
    std::cout << "USE_IMPORTED_LIBS is OFF\n";
#endif
}
