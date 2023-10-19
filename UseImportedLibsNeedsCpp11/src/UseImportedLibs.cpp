#include "UseImportedLibs.hpp"
#include "HeaderLibApi.hpp"
#include "SharedLibApi.hpp"
#include "SharedOrStaticLibApi.hpp"
#include "StaticLibApi.hpp"

namespace Code2
{
    namespace UseImportedLibs
    {
        void UseLibrary()
        {
            Code::HeaderLib::DoPublicTask();
            Code::SharedLib::DoPublicTask();
            Code::SharedOrStaticLib::DoPublicTask();
            Code::StaticLib::DoPublicTask();
        }
    
    } // ~namespace UseImportedLibs
} // ~namespace Code2
