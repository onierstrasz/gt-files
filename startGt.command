#! /bin/sh
#
# Start GT from a Terminal command, so error messages are logged there.
#
D=`dirname "$0"`
cd "$D"
ulimit -n 10240 # Increase the limit for the number of processes.
./GlamorousToolkit.app/Contents/MacOS/GlamorousToolkit \
  --image GlamorousToolkit.image
