# HASHES: https://www.lua.org/ftp/

define build_lua
	$(info Building $(1))
	tar xf $(1).tar.gz
	sed -i -e 's/^CC=/CC?=/' -e 's/^LIBS=/LIBS?=/' -e 's/^CFLAGS=/CFLAGS?=/' -e 's/^LDFLAGS=/LDFLAGS?=/' $(1)/src/Makefile
	@cd $(1) && CC="musl-gcc" CFLAGS="-Os -static -fPIC" LDFLAGS="-static" LIBS="" make posix
	@strip $(1)/src/luac $(1)/src/lua
endef

.PHONY: lua51 lua53 lua54

all: lua51 lua53 lua54

lua51: VERSION := 5.1.5
lua51:
	$(call build_lua,lua-${VERSION})
	@mv lua-$(VERSION)/src/lua lua51
	@mv lua-$(VERSION)/src/luac luac51
	@rm -rf lua-$(VERSION)

lua53: VERSION := 5.3.6
lua53:
	$(call build_lua,lua-${VERSION})
	@mv lua-$(VERSION)/src/lua lua53
	@mv lua-$(VERSION)/src/luac luac53
	@rm -rf lua-$(VERSION)

lua54: VERSION := 5.4.6
lua54:
	$(call build_lua,lua-${VERSION})
	@mv lua-$(VERSION)/src/lua lua54
	@mv lua-$(VERSION)/src/luac luac54
	@rm -rf lua-$(VERSION)


clean:
	rm -f luac51 lua51
	rm -f luac53 lua53
	rm -f luac54 lua54
