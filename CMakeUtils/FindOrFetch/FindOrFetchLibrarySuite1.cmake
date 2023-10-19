#[==================================================[
Find preinstaled LibrarySuite package or if it cannot be found fetch it from github 
and build it with the project
#]==================================================]
set(packageName LibrarySuite)
set(packageVersion 0.1.0)

#[==================================================[
Point the path to ${packageName}Config.cmake or ${packageName}-config.cmake
if the package is not on the standard search path nor in CMAKE_INSTALL_PREFIX
#]==================================================]

if(linkSharedOrStaticLibAsShared)

    set(sharedOrStaticType shared)

    if (WIN32 OR MSVC)
        set(CMAKE_FIND_LIBRARY_SUFFIXES ".dll")
        set(buildDir buildNinjaMC/Msvc)
    elseif(LINUX)
        set(CMAKE_FIND_LIBRARY_SUFFIXES ".so")
        set(buildDir buildNinjaMC/Gnu)
    elseif(APPLE)
        set(CMAKE_FIND_LIBRARY_SUFFIXES ".dylib;.so")
        set(buildDir buildNinjaMC/Clang)
    elseif (UNIX AND NOT APPLE)
        set(CMAKE_FIND_LIBRARY_SUFFIXES ".so")
        set(buildDir )
    endif()

    set(${packageName}_DIR 
        ../CreateAndUseLibraries/${buildDir}/install/${packageName}${packageVersion}/${sharedOrStaticType}/share/cmake
    )
    message(STATUS "linkSharedOrStaticLibAsShared: " ${linkSharedOrStaticLibAsShared} " --- targetSharedOrStaticLib will be linked as SHARED library")
    message(STATUS "${packageName}_DIR: ${${packageName}_DIR}")

else()

    set(sharedOrStaticType static)

    if (WIN32 OR MSVC)
        set(CMAKE_FIND_LIBRARY_SUFFIXES ".lib")
        set(buildDir buildNinjaMC/Msvc)
    elseif(LINUX)
        set(CMAKE_FIND_LIBRARY_SUFFIXES ".a")
        set(buildDir buildNinjaMC/Gnu)
    elseif(APPLE)
        set(CMAKE_FIND_LIBRARY_SUFFIXES ".a")
        set(buildDir buildNinjaMC/Clang)
    elseif (UNIX AND NOT APPLE)
        set(CMAKE_FIND_LIBRARY_SUFFIXES ".a")
        set(buildDir )
    endif()

    set(${packageName}_DIR 
        ../CreateAndUseLibraries/${buildDir}/install/${packageName}${packageVersion}/${sharedOrStaticType}/share/cmake
    )
    message(STATUS "linkSharedOrStaticLibAsShared: " ${linkSharedOrStaticLibAsShared} " --- targetSharedOrStaticLib will be linked as STATIC library")
    message(STATUS "${packageName}_DIR: ${${packageName}_DIR}")

endif()

# Omit REQUIRED keyword so as to be able to fetch the package if it is not installed
find_package(${packageName} ${packageVersion})

if(${packageName}_FOUND)
    message(STATUS "${packageName}_FOUND: ${${packageName}_FOUND}")
    message(STATUS "${packageName}_VERSION: ${${packageName}_VERSION}")
    message(STATUS "${packageName}_INCLUDE_DIRS: ${${packageName}_INCLUDE_DIRS}")
    message(STATUS "${packageName}_LIBRARIES: ${${packageName}_LIBRARIES}")
    message(STATUS "CMAKE_FIND_LIBRARY_SUFFIXES: ${CMAKE_FIND_LIBRARY_SUFFIXES}")   
else()
    include(FetchContent)
    set(FETCHCONTENT_QUIET FALSE)
    
    FetchContent_Declare(librarySuite1
        GIT_REPOSITORY  https://gitlab.com/cmakeexamples/librarieswithconfigcmake/createanduselibraries.git
        GIT_TAG         LibrarySuite1
        SOURCE_DIR      ${CMAKE_SOURCE_DIR}/External/${packageName}
        GIT_PROGRESS    TRUE
        GIT_SHALLOW     TRUE
        USES_TERMINAL_DOWNLOAD TRUE   # <---- only used by Ninja generator
    )

    FetchContent_MakeAvailable(librarySuite1)
endif()
