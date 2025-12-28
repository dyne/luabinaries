#!/bin/sh

# this script is needed to inscribe metadata in the .exe files
# targeting windows. it creates a .rs to be used when linking

# first argument is lua-N.N.N
>&2 echo "Stamp exe: $1"
version="`echo $1 | cut -d'-' -f2`"
vercommas="`echo $version | sed -e 's/\./,/g'`"
vershort="`echo $version | cut -d. -f1,2 --output-delimiter=''`"
>&2 echo "version: $version"
>&2 echo " commas: $vercommas"
>&2 echo "  short: $vershort"

date=`date +'%y%m%d'`
datecommas=`date +'%y,%m,%d'`

cat << EOF
1 VERSIONINFO
FILEVERSION     1,0,0,0
PRODUCTVERSION  ${vercommas},0
BEGIN
  BLOCK "StringFileInfo"
  BEGIN
    BLOCK "040904E4"
    BEGIN
      VALUE "CompanyName", "Dyne.org Foundation"
      VALUE "FileDescription", "Lua ${version} binary by Denis Roio <jaromil@dyne.org>"
      VALUE "FileVersion", "${date}"
      VALUE "InternalName", "lua${vershort}"
      VALUE "LegalCopyright", "Lua is Copyright (C) 1994-2025 by PUC-Rio"
      VALUE "OriginalFilename", "lua${vershort}.exe"
      VALUE "ProductName", "Lua"
      VALUE "ProductVersion", "${version}"
    END
  END
  BLOCK "VarFileInfo"
  BEGIN
    VALUE "Translation", 0x409, 1252
  END
END
EOF
