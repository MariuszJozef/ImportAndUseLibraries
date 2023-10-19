#[==================================================[
UseImportedLibs (executable program)
DO NOT call it "targetExe" because if fetching (instead of finding preinstalled libraries)
it will conflict with targetExe that is already defined in the sibling project:
https://github.com/MariuszJozef/CreateAndUseLibraries.git
#]==================================================]
add_executable(targetExe2)

target_include_directories(targetExe2
    PRIVATE
        hdr
)

target_sources(targetExe2
    PRIVATE
        src/MainUseImportedLibs.cpp
        hdr/UseImportedLibs.hpp
        src/UseImportedLibs.cpp
)

set_target_properties(targetExe2
    PROPERTIES
        OUTPUT_NAME                         UseImportedLibs
        DEBUG_POSTFIX                       _d
        RUNTIME_OUTPUT_DIRECTORY            ${CMAKE_BINARY_DIR}/buildOut/UseImportedLibsNeedsCpp11/bin/$<CONFIG>
        PDB_OUTPUT_DIRECTORY                ${CMAKE_BINARY_DIR}/buildOut/UseImportedLibsNeedsCpp11/pdb/$<CONFIG>
        RUNTIME_OUTPUT_DIRECTORY_<Config>   ${RUNTIME_OUTPUT_DIRECTORY}
        PDB_OUTPUT_DIRECTORY_<Config>       ${PDB_OUTPUT_DIRECTORY}
)

target_compile_features(targetExe2
    PRIVATE
        cxx_std_11
)

if(MSVC)

    target_compile_options(targetExe2 
        PRIVATE
            /EHsc
            /W2
            # /Wall
    )

else()

    target_compile_options(targetExe2 
        PRIVATE
            -Wall
            # -Wextra
            # -Wpedantic
    )

endif()

target_compile_definitions(targetExe2
    PRIVATE
        USE_IMPORTED_LIBS
)

#[==================================================[
On Windows copy *.dll needed at runtime by the .exe into the same directory as the .exe
#]==================================================]
option(isThereDllToLink "Switch OFF when not linking any DLLs, otherwise copy <empty> will fail!" ON)

if(WIN32 AND isThereDllToLink)
    add_custom_command(TARGET targetExe2 POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E echo "copy: $<TARGET_RUNTIME_DLLS:targetExe2>"
        COMMAND ${CMAKE_COMMAND} -E echo "to:   $<TARGET_FILE_DIR:targetExe2>"
        COMMAND ${CMAKE_COMMAND} -E copy_if_different 
                $<TARGET_RUNTIME_DLLS:targetExe2> 
                $<TARGET_FILE_DIR:targetExe2>
        COMMAND_EXPAND_LISTS
    )
endif()
