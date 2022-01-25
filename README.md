# IDO 5.3 -O2 Testing
A sandbox to test and document different `-O2` compilation scenarios with IDO 5.3.

## Docs
You can find documented examples and other notes under the [`docs/`](./docs/README.md) directory.

## Usage
0. Install prerequisites:
    - `make`
    - `binutils-mips-linux-gnu`
1. Write some C under `src/`.
2. Run `make FILE=<name of C FILE without .c>`.
    - Ex. `make FILE=test` will compile `src/test.c` and show its disassembly.
3. Observe assembly dump.
4. ???
5. Profit

> WARNING: Make sure all C source files use Unix line endings!
>
> Otherwise, IDO will fail with an error that looks something like:
> ```wrapper_sprintf: Assertion `0 && "non-implemented sprintf format"' failed.```

### File watcher
If you would like a file to be automatically recompiled when you save it, use `watch.sh` in this directory. It will automatically clear the terminal and show the new disassembly each time the file changes. Example: `./watch.sh test` will watch src/test.c.
- Requires `inotify-tools` package.
- *Note for WSL users*: This will not work unless the file is on your linux partition and your editor is running in WSL.
