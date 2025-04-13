# Luabinaries

This repository houses the most recent stable versions of the Lua language and creates static binaries ready to download and run.

We aim to create Lua interpreters that are optimized, compact and can run on most Lua supported platforms. 

So far we support:
- Linux x86 64bit (also known as amd64) - filename pattern `luaVV`
- Windows x86 64bit (win64) - filename pattern `luaVV.exe`
## Download

Direct download to our released binaries is possible using the following links:

- lua 5.1 for linux 64 https://github.com/dyne/luabinaries/releases/latest/download/lua51
- lua 5.3 for linux 64 https://github.com/dyne/luabinaries/releases/latest/download/lua53
- lua 5.4 for linux 64 https://github.com/dyne/luabinaries/releases/latest/download/lua54

Lua bytecode compilers are available simply by changing the file name to `luacVV`.

Releases are tagged with the GitHub hash and listed in the [Release page](https://github.com/dyne/luabinaries/releases/).

## Building

Make sure you installed the dependencies needed for building in your Linux system:

```
sudo apt-get install -y make musl musl-tools gcc-mingw-w64
```

The [Makefile](https://github.com/dyne/luabinaries/blob/main/Makefile) does everything needed using the original Lua source-code releases archived in this repository. Just run `make` to compile the linux binaries and cross-compile the Windows-executables.

The versions of the released binaries are listed below, the respective sources are available at https://lua.org/ftp:

- lua-5.1.5.tar.gz (Feb 13  2012) `7d5ea1b9cb6aa0b59ca3dde1c6adcb57ef83a1ba8e5432c0ecd06bf439b3ad88`
- lua-5.3.6.tar.gz (Sep 14  2020) `fc5fd69bb8736323f026672b1b7235da613d7177e72558893a0bdcd320466d60`
- lua-5.4.7.tar.gz (Jun 13  2024) `9fbf5e28ef86c69858f6d3d34eccc32e911c1a28b4120ff3e84aaa70cfbf1e30`

To build static binaries ready to run everywhere, we use [Musl](https://www.musl-libc.org/).

The released binaries are compressed to ~50% of their original size using [upx-ucl](https://upx.github.io/).

## Acknowledgements

This is not an "official" distribution of Lua binaries.

Lua is Copyright © 1994–2023 Lua.org, PUC-Rio.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

