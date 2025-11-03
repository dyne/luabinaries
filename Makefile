# HASHES: https://www.lua.org/ftp/

# Build functions for different platforms and architectures

# Linux x64 (musl static)
define build_lua_linux_x64
	$(info Building $(1) for Linux x64)
	mkdir -p build/linux-x64
	rm -rf $(1)
	tar xf $(1).tar.gz
	sed -i -e 's/^CC=/CC?=/' -e 's/^LIBS=/LIBS?=/' -e 's/^CFLAGS=/CFLAGS?=/' -e 's/^LDFLAGS=/LDFLAGS?=/' $(1)/src/Makefile
	@cd $(1) && CC="musl-gcc" CFLAGS="-O3 -static -fPIC" LDFLAGS="-static" LIBS="" make posix
	@strip $(1)/src/luac $(1)/src/lua
endef

# Linux arm64 (cross-compile with musl)
define build_lua_linux_arm64
	$(info Building $(1) for Linux ARM64)
	mkdir -p build/linux-arm64
	rm -rf $(1)
	tar xf $(1).tar.gz
	sed -i -e 's/^CC=/CC?=/' -e 's/^LIBS=/LIBS?=/' -e 's/^CFLAGS=/CFLAGS?=/' -e 's/^LDFLAGS=/LDFLAGS?=/' $(1)/src/Makefile
	@cd $(1) && CC="aarch64-linux-gnu-gcc" CFLAGS="-O3 -static" LDFLAGS="-static" LIBS="-lm" make posix
	@aarch64-linux-gnu-strip $(1)/src/luac $(1)/src/lua
endef

# Windows x64 (MinGW cross-compile)
define build_lua_win64
	$(info Building $(1) for Windows x64)
	mkdir -p build/win64
	rm -rf $(1)
	tar xf $(1).tar.gz
	sed -i -e 's/^CC=/CC?=/' -e 's/^LIBS=/LIBS?=/' -e 's/^CFLAGS=/CFLAGS?=/' -e 's/^LDFLAGS=/LDFLAGS?=/' $(1)/src/Makefile
	bash stamp-exe.sh "$(1)" > lua.rc
	x86_64-w64-mingw32-windres lua.rc -O coff -o $(1)/src/lua.res
	rm -r lua.rc
	@cd $(1) && \
	CC="$(shell which x86_64-w64-mingw32-gcc)" \
	LD="$(shell which x86_64-w64-mingw32-ld)" \
	AR="$(shell which x86_64-w64-mingw32-ar)" \
	RANLIB="$(shell which x86_64-w64-mingw32-ranlib)" \
	CFLAGS="-O3 -mthreads" \
	LDFLAGS=" -L/usr/x86_64-w64-mingw32/lib" \
	LIBS="lua.res -l:libm.a -l:libpthread.a -lssp" \
	make mingw
	@x86_64-w64-mingw32-strip $(1)/src/luac.exe $(1)/src/lua.exe
endef

# macOS builds (native, architecture determined by runner)
define build_lua_macos
	$(info Building $(1) for macOS $(2))
	mkdir -p build/macos-$(2)
	rm -rf $(1)
	tar xf $(1).tar.gz
	sed -i '' -e 's/^CC=/CC?=/' -e 's/^LIBS=/LIBS?=/' -e 's/^CFLAGS=/CFLAGS?=/' -e 's/^LDFLAGS=/LDFLAGS?=/' $(1)/src/Makefile
	@cd $(1) && CC="clang" CFLAGS="-O3" LDFLAGS="" LIBS="" make macosx
	@strip $(1)/src/luac $(1)/src/lua
endef

.PHONY: all linux-x64 linux-arm64 windows macos-x64 macos-arm64 clean

# Backwards compatibility aliases
linux: linux-x64
macos: macos-x64

all: linux-x64 linux-arm64 windows macos-x64 macos-arm64

# Linux x64 targets
linux-x64: lua51-linux-x64 lua53-linux-x64 lua54-linux-x64

lua51-linux-x64: VERSION := 5.1.5
lua51-linux-x64:
	$(call build_lua_linux_x64,lua-${VERSION})
	@mv lua-$(VERSION)/src/lua build/linux-x64/lua51
	@mv lua-$(VERSION)/src/luac build/linux-x64/luac51
	@rm -rf lua-$(VERSION)

lua53-linux-x64: VERSION := 5.3.6
lua53-linux-x64:
	$(call build_lua_linux_x64,lua-${VERSION})
	@mv lua-$(VERSION)/src/lua build/linux-x64/lua53
	@mv lua-$(VERSION)/src/luac build/linux-x64/luac53
	@rm -rf lua-$(VERSION)

lua54-linux-x64: VERSION := 5.4.8
lua54-linux-x64:
	$(call build_lua_linux_x64,lua-${VERSION})
	@mv lua-$(VERSION)/src/lua build/linux-x64/lua54
	@mv lua-$(VERSION)/src/luac build/linux-x64/luac54
	@rm -rf lua-$(VERSION)

# Linux ARM64 targets
linux-arm64: lua51-linux-arm64 lua53-linux-arm64 lua54-linux-arm64

lua51-linux-arm64: VERSION := 5.1.5
lua51-linux-arm64:
	$(call build_lua_linux_arm64,lua-${VERSION})
	@mv lua-$(VERSION)/src/lua build/linux-arm64/lua51-linux-arm64
	@mv lua-$(VERSION)/src/luac build/linux-arm64/luac51-linux-arm64
	@rm -rf lua-$(VERSION)

lua53-linux-arm64: VERSION := 5.3.6
lua53-linux-arm64:
	$(call build_lua_linux_arm64,lua-${VERSION})
	@mv lua-$(VERSION)/src/lua build/linux-arm64/lua53-linux-arm64
	@mv lua-$(VERSION)/src/luac build/linux-arm64/luac53-linux-arm64
	@rm -rf lua-$(VERSION)

lua54-linux-arm64: VERSION := 5.4.8
lua54-linux-arm64:
	$(call build_lua_linux_arm64,lua-${VERSION})
	@mv lua-$(VERSION)/src/lua build/linux-arm64/lua54-linux-arm64
	@mv lua-$(VERSION)/src/luac build/linux-arm64/luac54-linux-arm64
	@rm -rf lua-$(VERSION)

# Windows x64 targets
windows: lua51-windows lua53-windows lua54-windows

lua51-windows: VERSION := 5.1.5
lua51-windows:
	-$(call build_lua_win64,lua-${VERSION})
	-@mv lua-$(VERSION)/src/lua.exe build/win64/lua51.exe
	-@mv lua-$(VERSION)/src/luac.exe build/win64/luac51.exe
	-@mv lua-$(VERSION)/src/lua51.dll build/win64/lua51.dll
	@rm -rf lua-$(VERSION)

lua53-windows: VERSION := 5.3.6
lua53-windows:
	-$(call build_lua_win64,lua-${VERSION})
	-@mv lua-$(VERSION)/src/lua.exe build/win64/lua53.exe
	-@mv lua-$(VERSION)/src/luac.exe build/win64/luac53.exe
	-@mv lua-$(VERSION)/src/lua53.dll build/win64/lua53.dll
	@rm -rf lua-$(VERSION)

lua54-windows: VERSION := 5.4.8
lua54-windows:
	-$(call build_lua_win64,lua-${VERSION})
	-@mv lua-$(VERSION)/src/lua.exe build/win64/lua54.exe
	-@mv lua-$(VERSION)/src/luac.exe build/win64/luac54.exe
	-@mv lua-$(VERSION)/src/lua54.dll build/win64/lua54.dll
	@rm -rf lua-$(VERSION)

# macOS x64 targets
macos-x64: lua51-macos-x64 lua53-macos-x64 lua54-macos-x64

lua51-macos-x64: VERSION := 5.1.5
lua51-macos-x64:
	$(call build_lua_macos,lua-${VERSION},x64)
	@mv lua-$(VERSION)/src/lua build/macos-x64/lua51-macos-x64
	@mv lua-$(VERSION)/src/luac build/macos-x64/luac51-macos-x64
	@rm -rf lua-$(VERSION)

lua53-macos-x64: VERSION := 5.3.6
lua53-macos-x64:
	$(call build_lua_macos,lua-${VERSION},x64)
	@mv lua-$(VERSION)/src/lua build/macos-x64/lua53-macos-x64
	@mv lua-$(VERSION)/src/luac build/macos-x64/luac53-macos-x64
	@rm -rf lua-$(VERSION)

lua54-macos-x64: VERSION := 5.4.8
lua54-macos-x64:
	$(call build_lua_macos,lua-${VERSION},x64)
	@mv lua-$(VERSION)/src/lua build/macos-x64/lua54-macos-x64
	@mv lua-$(VERSION)/src/luac build/macos-x64/luac54-macos-x64
	@rm -rf lua-$(VERSION)

# macOS ARM64 targets
macos-arm64: lua51-macos-arm64 lua53-macos-arm64 lua54-macos-arm64

lua51-macos-arm64: VERSION := 5.1.5
lua51-macos-arm64:
	$(call build_lua_macos,lua-${VERSION},arm64)
	@mv lua-$(VERSION)/src/lua build/macos-arm64/lua51-macos-arm64
	@mv lua-$(VERSION)/src/luac build/macos-arm64/luac51-macos-arm64
	@rm -rf lua-$(VERSION)

lua53-macos-arm64: VERSION := 5.3.6
lua53-macos-arm64:
	$(call build_lua_macos,lua-${VERSION},arm64)
	@mv lua-$(VERSION)/src/lua build/macos-arm64/lua53-macos-arm64
	@mv lua-$(VERSION)/src/luac build/macos-arm64/luac53-macos-arm64
	@rm -rf lua-$(VERSION)

lua54-macos-arm64: VERSION := 5.4.8
lua54-macos-arm64:
	$(call build_lua_macos,lua-${VERSION},arm64)
	@mv lua-$(VERSION)/src/lua build/macos-arm64/lua54-macos-arm64
	@mv lua-$(VERSION)/src/luac build/macos-arm64/luac54-macos-arm64
	@rm -rf lua-$(VERSION)

clean:
	rm -rf build
