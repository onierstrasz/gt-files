#! /bin/sh
D=`dirname "$0"`
cd "$D"
if test -d default
then
	cd default
else
	cd lepiter
fi

fgrep '"uuid" :' -h *.lepiter | sort | uniq -c | sort -rn | head
