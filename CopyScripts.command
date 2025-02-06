#! /bin/sh
#
# Copy startup command and script to downloaded release images.
#
D=`dirname "$0"`
cd "$D"
F="/Users/oscar/Library/CloudStorage/Dropbox/feenk/gt-files"

for arg in Glam*
do
	if test -d "$arg"
	then
		cp "$F/startGt.command" "$arg/_startGt.command"
		cp "$F/startup.st" "$arg"
	fi
done
