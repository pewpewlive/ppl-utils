# [WIP] ppl-utils

This repository hosts the code source for the PewPew Live public development environment.

## Getting started

1. [Download a prebuilt archive] for your platform.
1. **Important**: extract the zip. Running the binary directly from the zip will not work.
1. Run the ppl-utils binary.
    * On windows: double click `ppl-utils.exe`. Windows warn you that it's dangerous. If you downloaded the binary from this github page, you'll be fine.
    * On macOS: open a terminal. Drag and drop the `ppl-utils` binary into it. Press enter.
    * On linux: execute `ppl-utils`.
1. This creates a web server that hosts PewPew Live on the port 9000. Point your browser to
  [http://localhost:9000/pewpew.html] to launch PewPew Live.
1. When launched, PewPew Live lists the level found in the `content/levels/` directory.
  Play a level by clicking on it.
1. Change code in `content/levels/` and see how it affects the levels.
1. Open the browser's Javascript console to see the error messages.
1. Read the [API documentation].
1. Ask questions in the [Discord chat room].

## Lua Style guide
We try to follow [LuaRocks's style guide].
The only change is that we use 2 space indentation to be consistent with the rest of PewPew's codebase.

## Building the server

### For local development
`go build .` creates the ppl-utils binary.
**Important**: `go run .` won't work.

### To generate the archives for all the platforms
`python generate_archives.py`

[Download a prebuilt archive]: https://github.com/jyaif/ppl-utils/tags
[http://localhost:9000/files/pewpew.html]: http://localhost:9000/files/pewpew.html
[LuaRocks's style guide]: https://github.com/luarocks/lua-style-guide
[API documentation]: https://pewpew.live/documentation/main.html
[Discord chat room]: https://discord.gg/YvGd2pF