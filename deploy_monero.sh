#!/bin/bash

DIRS="temp bin data"
for DIR in $DIRS ; do
    if [ ! -d "$DIR" ] ; then
        mkdir "$DIR"
    fi
done

rm -f ./bin/*

TMPFILE="temp/cli-wallet.tar.bz2"
stat "$TMPFILE" >/dev/null 2>&1
while [ $? -ne 0 ] ; do
    if [ -f "$TMPFILE" ] ; then
        rm "$TMPFILE"
    fi
    wget -q -O "$TMPFILE" https://downloads.getmonero.org/cli/linux64
done
tar --strip-components=1 --one-top-level=bin -x -v -j -f "$TMPFILE"
if [ $? -ne 0 ] ; then
    echo "Error decompressing Monero application. Exiting."
    exit 1
fi
rm -rf temp

exit 0

# vim: set sts=4 et tw=0 :
