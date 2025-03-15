#! /bin/sh
# Use this script to run GT in debug mode on MacOS
D=`dirname "$0"`
cd "$D"
ulimit -n 10240
codesign --force --deep --sign - GlamorousToolkit.app
echo "NB -- from lldb run this:"
echo "run GlamorousToolkit.image --interactive"
lldb ./GlamorousToolkit.app/Contents/MacOS/GlamorousToolkit-cli
