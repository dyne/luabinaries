# HASHES: https://www.lua.org/ftp/

# default is linux "amd64" aka x86 64bit
define build_lua_linux
	$(info Building $(1))
	mkdir -p build/linux
	rm -rf $(1)
	tar xf $(1).tar.gz
	sed -i -e 's/^CC=/CC?=/' -e 's/^LIBS=/LIBS?=/' -e 's/^CFLAGS=/CFLAGS?=/' -e 's/^LDFLAGS=/LDFLAGS?=/' $(1)/src/Makefile
	@cd $(1) && CC="musl-gcc" CFLAGS="-O3 -static -fPIC" LDFLAGS="-static" LIBS="" make posix
	@strip $(1)/src/luac $(1)/src/lua
endef

define build_lua_win64
	$(info Building $(1))
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

.PHONY: lua51 lua53 lua54

all: linux windows

windows: lua51-windows lua53-windows lua54-windows

linux: lua51 lua53 lua54


lua51: VERSION := 5.1.5
lua51:
	$(call build_lua_linux,lua-${VERSION})
	@mv lua-$(VERSION)/src/lua build/linux/lua51
	@mv lua-$(VERSION)/src/luac build/linux/luac51
	@rm -rf lua-$(VERSION)

lua53: VERSION := 5.3.6
lua53:
	$(call build_lua_linux,lua-${VERSION})
	@mv lua-$(VERSION)/src/lua build/linux/lua53
	@mv lua-$(VERSION)/src/luac build/linux/luac53
	@rm -rf lua-$(VERSION)

lua54: VERSION := 5.4.6
lua54:
	$(call build_lua_linux,lua-${VERSION})
	@mv lua-$(VERSION)/src/lua build/linux/lua54
	@mv lua-$(VERSION)/src/luac build/linux/luac54
	@rm -rf lua-$(VERSION)

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

lua54-windows: VERSION := 5.4.6
lua54-windows:
	-$(call build_lua_win64,lua-${VERSION})
	-@mv lua-$(VERSION)/src/lua.exe build/win64/lua54.exe
	-@mv lua-$(VERSION)/src/luac.exe build/win64/luac54.exe
	-@mv lua-$(VERSION)/src/lua54.dll build/win64/lua54.dll
	@rm -rf lua-$(VERSION)


clean:
	rm -rf build
