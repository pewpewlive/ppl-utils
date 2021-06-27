mkdir -p out

CMAKE_MAKE_PROGRAM=cmake

cmake -E chdir out cmake -DOS_WEB:BOOL=true -DPPL_UTILS:BOOL=true -DCMAKE_TOOLCHAIN_FILE=/Users/jif/Developer/emsdk/upstream/emscripten/cmake/Modules/Platform/Emscripten.cmake -DCMAKE_BUILD_TYPE=MinSizeRel -G "Unix Makefiles" ../../../../client