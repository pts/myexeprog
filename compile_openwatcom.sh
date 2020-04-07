#! /bin/sh
# by pts@fazekas.hu at Tue Apr  7 23:15:20 CEST 2020
#
# See https://ptspts.blogspot.com/2020/04/openwatcom-exeprog.html
# for installation and docs.
#

cp binw/dos32a.exe binl/
chmod +x binl/owcc binl/wcc binl/wcc386 binl/wlink
# Without setting $WATCOM, emu87.lib, clib*.lib etc. won't be found.
# Without setting $PATH, specs.owc won't be found.
# Without setting $INCLUDE, `#include <...>' won't work.
# See https://wiki.archlinux.org/index.php/Open_Watcom for INCLUDE specific
# to the target OS (-b...).
export WATCOM="$PWD"
export PATH="$PWD/binl:$PATH" INCLUDE="$PWD/h"
set -ex
owcc    -bdos -mcmodel=l -o owprog.dosl.exe  myprog.c
owcc    -bdos -mcmodel=s -o owprog.doss.exe  myprog.c
owcc    -bdos32a         -o owprog.dos32.exe myprog.c
owcc    -bdos4g          -o owprog.dosx.exe  myprog.c
owcc    -bos2            -o owprog.os216.exe myprog.c
owcc    -bos2v2          -o owprog.os232.exe myprog.c
owcc    -bwindows        -o owprog.win16.exe myprog.c
owcc    -bnt             -o owprog.win32.exe myprog.c
owcc -c -bdos -mcmodel=l -o owprog.dosl.obj  myprog.c
owcc -c -bdos -mcmodel=s -o owprog.doss.obj  myprog.c
owcc -c -bdos32a         -o owprog.dos32.obj myprog.c
owcc -c -bdos4g          -o owprog.dosx.obj  myprog.c
owcc -c -bos2            -o owprog.os216.obj myprog.c
owcc -c -bos2v2          -o owprog.os232.obj myprog.c
owcc -c -bwindows        -o owprog.win16.obj myprog.c
owcc -c -bnt             -o owprog.win32.obj myprog.c
rm -f owprog.o

: All OK.
