# CMake demo of how to find/fetch and link libraries that have a `<packageName>Config.cmake` file

This project uses a `<packageName>Config.cmake` of a third party installable project to link the third party libraries (header-only, static, shared) and run some code with them. If the third library is preinstalled on the system, a flag 
```
-D <packageName>_DIR=path/to/dir/where/<packageName>Config.cmake/is/located
```
should be provided at the CMake's configure step. If the library is not installed or the path is wrong, then CMake will fetch the library from a remote repository (provided the URL is correct) and incorporate it into its own build.

The third party project in question is [CreateAndUseLibraries](https://github.com/MariuszJozef/CreateAndUseLibraries.git) and its package name is "LibrarySuite", so the flag variable is: `LibrarySuite_DIR` and needs to point to the location of LibrarySuiteConfig.cmake.

It is noteworthy that the current project needs only to be compiled with C++11 even though the libraries it uses require C++14, C++17, C++20 for compilation. This remains true even when the source code of the libraries gets incorporated into and build with this project on the fly (as happens when CMake fetches the libraries from a remote repo). Had it not been for `<packageName>Config.cmake`, then this project would not compile merely with C++11.

## Some sample commands to configure, build/link, and run the program
```
git clone --depth 1 https://github.com/MariuszJozef/ImportAndUseLibraries.git
cd ImportAndUseLibraries
```
```
cmake --preset NinjaMC-Msvc -D linkSharedOrStaticLibAsShared=<ON/OFF> -D LibrarySuite_DIR=C:/Packages/LibrarySuite/share/cmake
cmake --build --preset NinjaMC-Msvc --config Debug --target run
cmake --build --preset NinjaMC-Msvc --config Release --target run
cmake --build --preset NinjaMC-Msvc --config RelWithDebInfo --target run
```
```
cmake --preset NinjaMC-Gnu -D linkSharedOrStaticLibAsShared=<ON/OFF> -D LibrarySuite_DIR=../CreateAndUseLibraries/buildMake/Gnu/install/LibrarySuite0.1.0/static/share/cmake/
cmake --build --preset NinjaMC-Gnu --config Debug --target run
cmake --build --preset NinjaMC-Gnu --config Release --target run
cmake --build --preset NinjaMC-Gnu --config RelWithDebInfo --target run
```
```
cmake --preset NinjaMC-Gnu -D linkSharedOrStaticLibAsShared=<ON/OFF> -D LibrarySuite_DIR=../CreateAndUseLibraries/buildMake/Gnu/install/LibrarySuite0.1.0/shared/share/cmake/
cmake --build --preset NinjaMC-Clang --config Debug --target run
cmake --build --preset NinjaMC-Clang --config Release --target run
cmake --build --preset NinjaMC-Clang --config RelWithDebInfo --target run
```
