#!/bin/bash

mkdir dev
mkdir dev/pts
mkdir etc
mkdir etc/init.d
mkdir lib
mkdir mnt
mkdir opt
mkdir proc
mkdir root
mkdir sys
mkdir tmp
mkdir var
mkdir var/log
mkdir -p usr/share/udhcpc/

CROSS_COMPILE=arm-linux-gnueabihf-
CROSS_LIBS_PATH=`dirname $(which ${CROSS_COMPILE}gcc)`/../arm-linux-gnueabihf/libc/lib

cd lib

for f in `find ${CROSS_LIBS_PATH} -maxdepth 1 -type f`
do
        cp -a ${f} .
        file=`basename ${f}`
        if (file -b ${file} | grep -v "ASCII" > /dev/null)
        then
                ${CROSS_COMPILE}strip ${file}
        fi
done
find ${CROSS_LIBS_PATH} -maxdepth 1 -type l -exec cp -a {} . \;
cd - > /dev/null
