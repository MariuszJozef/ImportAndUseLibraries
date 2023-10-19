#[==================================================[
UseImportedLibs (executable program)
#]==================================================]
add_executable(targetExe) 

target_include_directories(targetExe
    PRIVATE
        hdr
)

target_sources(targetExe
    PRIVATE
        src/MainUseImportedLibs.cpp
        hdr/UseImportedLibs.hpp
        src/UseImportedLibs.cpp
)

set_target_properties(targetExe
    PROPERTIES
        OUTPUT_NAME                         UseImportedLibs
        DEBUG_POSTFIX                       _d
        RUNTIME_OUTPUT_DIRECTORY            ${CMAKE_BINARY_DIR}/buildOut/UseImportedLibsNeedsCpp11/bin/$<CONFIG>
        PDB_OUTPUT_DIRECTORY                ${CMAKE_BINARY_DIR}/buildOut/UseImportedLibsNeedsCpp11/pdb/$<CONFIG>
        RUNTIME_OUTPUT_DIRECTORY_<Config>   ${RUNTIME_OUTPUT_DIRECTORY}
        PDB_OUTPUT_DIRECTORY_<Config>       ${PDB_OUTPUT_DIRECTORY}
)

target_compile_features(targetExe
    PRIVATE
        cxx_std_11
)

if(MSVC)

    target_compile_options(targetExe 
        PRIVATE
            /EHsc
            /W2
            # /Wall
    )

else()

    target_compile_options(targetExe 
        PRIVATE
            -Wall
            # -Wextra
            # -Wpedantic
    )

endif()

target_compile_definitions(targetExe
    PRIVATE
        USE_IMPORTED_LIBS
)

#[==================================================[
On Windows copy *.dll needed at runtime by the .exe into the same directory as the .exe
#]==================================================]
option(isThereDllToLink "Switch OFF when not linking any DLLs, otherwise copy <empty> will fail!" ON)

if(WIN32 AND isThereDllToLink)
    add_custom_command(TARGET targetExe POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E echo "copy: $<TARGET_RUNTIME_DLLS:targetExe>"
        COMMAND ${CMAKE_COMMAND} -E echo "to:   $<TARGET_FILE_DIR:targetExe>"
        COMMAND ${CMAKE_COMMAND} -E copy_if_different 
                $<TARGET_RUNTIME_DLLS:targetExe> 
                $<TARGET_FILE_DIR:targetExe>
        COMMAND_EXPAND_LISTS
    )
endif()
