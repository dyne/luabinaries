# Luabinaries

This repository mirrors the latest stable releases of Lua language and builds static binaries ready for use on any GNU+Linux x86 64bit machine.

The Lua release series provided are 5.1, 5.3 and 5.4 - binaries will carry the two versions as number, i.e: lua51 and luac51.

## Download

Direct download to the binaries is possible using the following links:

- lua 5.1 for linux 64 https://github.com/dyne/luabinaries/releases/latest/download/lua51
- lua 5.3 for linux 64 https://github.com/dyne/luabinaries/releases/latest/download/lua53
- lua 5.4 for linux 64 https://github.com/dyne/luabinaries/releases/latest/download/lua54

Lua bytecode compilers are available simply changing the file name to `luacNN`.

Releases are tagged with the github hash and listed in the [Release page](https://github.com/dyne/luabinaries/releases/).

## Building

The Makefile does everything needed using the original Lua source-code releases archived in this repository.

They are available on https://lua.org/ftp and listed below:

- lua-5.1.5.tar.gz (Feb 13  2012) `7d5ea1b9cb6aa0b59ca3dde1c6adcb57ef83a1ba8e5432c0ecd06bf439b3ad88`
- lua-5.3.6.tar.gz (Sep 14  2020) `fc5fd69bb8736323f026672b1b7235da613d7177e72558893a0bdcd320466d60`
- lua-5.4.6.tar.gz (May  2 2023) `2640fc56a795f29d28ef15e13c34a47e223960b0240e8cb0a82d9b0738695333`

To build static binaries ready to run everywhere we use [Musl](https://www.musl-libc.org/).

## Acknowledgements

Lua is Copyright (C) 1994-2023 by PUC-Rio

It is released using MIT license

These binaries are built from its unmodified source and released under the same license.

