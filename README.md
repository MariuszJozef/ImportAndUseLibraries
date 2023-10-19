~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
WINDOWS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

cmake --preset NinjaMC-Msvc -D linkSharedOrStaticLibAsShared=OFF
cmake --build --preset NinjaMC-Msvc --config Debug --target run
cmake --build --preset NinjaMC-Msvc --config Release --target run
cmake --build --preset NinjaMC-Msvc --config RelWithDebInfo --target run

cmake --preset NinjaMC-Msvc -D linkSharedOrStaticLibAsShared=ON
cmake --build --preset NinjaMC-Msvc --config Debug --target run
cmake --build --preset NinjaMC-Msvc --config Release --target run
cmake --build --preset NinjaMC-Msvc --config RelWithDebInfo --target run

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
LINUX
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

cmake --preset NinjaMC-Gnu -D linkSharedOrStaticLibAsShared=OFF
cmake --build --preset NinjaMC-Gnu --config Debug --target run
cmake --build --preset NinjaMC-Gnu --config Release --target run
cmake --build --preset NinjaMC-Gnu --config RelWithDebInfo --target run

cmake --preset NinjaMC-Gnu -D linkSharedOrStaticLibAsShared=ON
cmake --build --preset NinjaMC-Gnu --config Debug --target run
cmake --build --preset NinjaMC-Gnu --config Release --target run
cmake --build --preset NinjaMC-Gnu --config RelWithDebInfo --target run

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
MAC
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

cmake --preset NinjaMC-Clang -D linkSharedOrStaticLibAsShared=OFF
cmake --build --preset NinjaMC-Clang --config Debug --target run
cmake --build --preset NinjaMC-Clang --config Release --target run
cmake --build --preset NinjaMC-Clang --config RelWithDebInfo --target run

cmake --preset NinjaMC-Clang -D linkSharedOrStaticLibAsShared=ON
cmake --build --preset NinjaMC-Clang --config Debug --target run
cmake --build --preset NinjaMC-Clang --config Release --target run
cmake --build --preset NinjaMC-Clang --config RelWithDebInfo --target run
