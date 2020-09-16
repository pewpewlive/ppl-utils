# [WIP] ppl-utils

Disclaimer: this repo is a WIP. Some important files are missing.

This repository hosts the code source for the PewPew Live public development environment.

## Getting started

1. Download a prebuilt archive for your platform (TODO: upload the prebuilt archives).
1. Run the utils_server binary.
    * On windows: double click `utils_server.exe`
    * On macOS: open a terminal. Drag and drop `the utils_server` binary into it. Press enter.
    * On linux: execute `utils_server`.
1. This creates a web server that hosts PewPew Live on the port 9000. Point your browser to
  [http://localhost:9000/files/pewpew.html] to launch PewPew Live.
1. When launched, PewPew Live loads the files from the `content/dynamic/` directory and
  display the list of levels it has found. Play a level by clicking on it.

## Lua Style guide
We try to follow [LuaRocks's style guide].
The only change is that we use 2 space indentation to be consistent with the rest of
PewPew's codebase.

## Building the server

### For local development
`go build utils_server.go`

### To generate the archives for all the platforms
`./generate_archives.py`

[http://localhost:9000/files/pewpew.html]: http://localhost:9000/files/pewpew.html
[LuaRocks's style guide]: https://github.com/luarocks/lua-style-guide

