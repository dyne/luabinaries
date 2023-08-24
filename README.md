# Luabinaries

This repository houses the most recent stable versions of the Lua language and creates static binaries that are compatible with any GNU+Linux x86 64bit device.

Our aim is to create Lua interpreters that are very compact and can be used directly after downloading, and they are completely static binaries that can run on any distribution. As part of our efforts to achieve this goal, we remove the debugging symbols and compress them.

## Download

Direct download to our released binaries is possible using the following links:

- lua 5.1 for linux 64 https://github.com/dyne/luabinaries/releases/latest/download/lua51
- lua 5.3 for linux 64 https://github.com/dyne/luabinaries/releases/latest/download/lua53
- lua 5.4 for linux 64 https://github.com/dyne/luabinaries/releases/latest/download/lua54

Lua bytecode compilers are available simply by changing the file name to `luacNN`.

Releases are tagged with the GitHub hash and listed in the [Release page](https://github.com/dyne/luabinaries/releases/).

## Building

The [Makefile](https://github.com/dyne/luabinaries/blob/main/Makefile) does everything needed using the original Lua source-code releases archived in this repository.

They are available on https://lua.org/ftp and listed below:

- lua-5.1.5.tar.gz (Feb 13  2012) `7d5ea1b9cb6aa0b59ca3dde1c6adcb57ef83a1ba8e5432c0ecd06bf439b3ad88`
- lua-5.3.6.tar.gz (Sep 14  2020) `fc5fd69bb8736323f026672b1b7235da613d7177e72558893a0bdcd320466d60`
- lua-5.4.6.tar.gz (May  2 2023) `2640fc56a795f29d28ef15e13c34a47e223960b0240e8cb0a82d9b0738695333`

To build static binaries ready to run everywhere, we use [Musl](https://www.musl-libc.org/).

To compress the released binaries at ~50% of their original size we use [upx-ucl](https://upx.github.io/).

## Acknowledgements

This is not an "official" distribution of Lua binaries.

Lua is Copyright © 1994–2023 Lua.org, PUC-Rio.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

