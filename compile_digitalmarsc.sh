#! /bin/sh
# by pts@fazekas.hu at Tue Apr  7 23:15:20 CEST 2020
#
# Cross-compile on Linux Wine with Digital Mars C to various EXE targets.
#
# See https://ptspts.blogspot.com/2020/04/digitalmarsc-exeprog.html
# for installation and docs.
#
# These command-lines fail:
#
# * dm/bin/dmc    -mo -v0 -odcprog.os216.exe myprog.c <nul
#   -mo unsupported
# * dm/bin/dmc -c -mo -v0 -odcprog.os216.obj myprog.c <nul
#   -mo unsupported
# * dm/bin/dmc    -mf -v0 -odcprog.os232.exe myprog.c <nul
#   Wants to run link386.exe, an OS/2 binary. Wine can't run it.
#

# TODO(pts): Exit on the first error from wine.
# TODO(pts): Display commands.
DISPLAY= wine cmd <<'END' && rm -f dcprog.*.map && exit
@echo off
echo .
echo Compiling...
dm/bin/dmc    -ml         -v0 -odcprog.dosl.exe  myprog.c <nul
dm/bin/dmc    -ms         -v0 -odcprog.doss.exe  myprog.c <nul
dm/bin/dmc    -mx x32.lib -v0 -odcprog.dos32.exe myprog.c <nul
dm/bin/dmc    -mn         -v0 -odcprog.win32.exe myprog.c <nul
dm/bin/dmc -c -ml         -v0 -odcprog.dosl.obj  myprog.c <nul
dm/bin/dmc -c -ms         -v0 -odcprog.doss.obj  myprog.c <nul
dm/bin/dmc -c -mx         -v0 -odcprog.dos32.obj myprog.c <nul
dm/bin/dmc -c -mn         -v0 -odcprog.win32.obj myprog.c <nul
dm/bin/dmc -c -mf         -v0 -odcprog.os232.obj myprog.c <nul
END
rm -f dcprog.*.map
echo "$0: win32 command failed" >&2
echo ": All OK."
exit 2
