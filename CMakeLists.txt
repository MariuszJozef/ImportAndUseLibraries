cmake_minimum_required(VERSION 3.26.0...3.26.3)

include(CMakeUtils/Handy/DisallowInSourceBuilds.cmake) # Comment out to allow
include(CMakeUtils/Handy/SelectCompilerViaFlagIfNotUsingCMakePresets.cmake) # or else default compiler will be used

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
project(UseImportedLibs VERSION 0.1.0 LANGUAGES CXX)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

include(CMakeUtils/Handy/DisplayGenericInfo.cmake) # Comment out to suppress

#[==================================================[
Find or fetch a library and display its cmake targets
#]==================================================]
option(linkSharedOrStaticLibAsShared "OFF to link as static library, ON as shared - on Windows the latter requires the *.dll to be copied next to the .exe (this is done in add_subdirectory below)" OFF)

include(GNUInstallDirs) # do NOT comment out!
include(CMakeUtils/FindOrFetch/FindOrFetchLibrarySuite1.cmake)

get_property(importTargets1 DIRECTORY ${SOURCE_DIR} PROPERTY IMPORTED_TARGETS)
message(STATUS "importTargets1: ${importTargets1}")

#[==================================================[
Build (sub)project(s)
#]==================================================]
add_subdirectory(UseImportedLibsNeedsCpp11)

#[==================================================[
Link executable with found/fetched libraries
#]==================================================]
target_link_libraries(targetExe2 
    PRIVATE 
        LibrarySuite::HeaderLib
        LibrarySuite::SharedLib
        LibrarySuite::SharedOrStaticLib
        LibrarySuite::StaticLib
)

#[==================================================[
Run the executable 
DO NOT call it "run" because if fetching (instead of finding preinstalled libraries)
it will conflict with "run" that is already defined in the sibling project:
https://github.com/MariuszJozef/CreateAndUseLibraries.git
#]==================================================]
add_custom_target(run2
    COMMAND ${CMAKE_COMMAND} -E echo "execute: $<TARGET_FILE:targetExe2>"
    COMMAND $<TARGET_FILE:targetExe2>
)

#[==================================================[
(Optional) IDE solution name
Must be after all other projects since last project(...) is used as solution name
#]==================================================]
if (CMAKE_GENERATOR MATCHES "Visual Studio" OR  # any VS generator
    CMAKE_GENERATOR MATCHES "Eclipse CDT4")     # any Eclipse generator

    project(ImportLibrariesWithConfigCMake)

endif()
