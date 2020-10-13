# ppl-utils

This repository hosts the code source and documentation for the PewPew Live
development environment.
It allows anyone to create custom levels for PewPew Live.

## Getting started

1. [Download a prebuilt archive] for your platform.
1. **Important: extract the zip.** Running the binary directly from the zip will not work.
1. Run the ppl-utils binary.
    * On windows: double click `ppl-utils.exe`. Windows warn you that it's dangerous. If you downloaded the binary from this github page, you'll be fine.
    * On macOS: open a terminal. Drag and drop the `ppl-utils` binary into it. Press enter.
    * On linux: execute `ppl-utils`.
1. The binary creates a web server that hosts PewPew Live on the port 9000. Point your browser to
  http://localhost:9000/pewpew.html to launch PewPew Live.
1. When launched, PewPew Live lists the level found in the `content/levels/` directory.
  Play a level by clicking on it.
1. Change code in `content/levels/` and see how it affects the existing levels.
1. Open the browser's Javascript console to see the error messages.
1. Read the [API documentation].
1. Ask questions in the [Discord chat room].

## Publishing process

Once you've created a level and that you've thourougly tested it, tell me about it on the
[Discord chat room] and I will review the level and publish it.
A more automatic process may be set in place later, depending on the demand.

## Recommended Lua Style guide

When writing code, it is recommended to follow [LuaRocks's style guide], but using 2 space
indentation to be consistent with the rest of PewPew's codebase.

## Building the server

If you don't want (or can't) use one of the prebuilt binaries, you can build the binaries yourself.
The only requirement is to have golang 1.14 installed on your system.
After obtaining the source code, build with `go build`.

[Download a prebuilt archive]: https://github.com/jyaif/ppl-utils/tags
[LuaRocks's style guide]: https://github.com/luarocks/lua-style-guide
[API documentation]: https://jyaif.github.io/ppl-utils
[Discord chat room]: https://discord.gg/YvGd2pF