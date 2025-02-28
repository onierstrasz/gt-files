#! /bin/sh
#
# AC suggests this to debug GT freezing
#
D=`dirname "$0"`
cd "$D"
ulimit -n 10240

codesign --force --deep --sign - GlamorousToolkit.app
lldb ./GlamorousToolkit.app/Contents/MacOS/GlamorousToolkit-cli

exit
# Then in lldb:
run GlamorousToolkit.image --interactive
