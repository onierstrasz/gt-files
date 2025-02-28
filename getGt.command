#! /bin/sh
#
# Script to build GlamorousToolkit, install some scripts, and create a zipped backup.
# Caveat: this script assumes you are running on a Mac.
# probably some small changes will be needed for Linux or Windoze.
#
# Oscar Nierstrasz 2023
# https://creativecommons.org/licenses/by/4.0/
#
# https://github.com/onierstrasz/gt-startup/tree/main/gt-files

# This directory, i.e., where GT will be installed.
D=`dirname "$0"`
cd "$D"

# Folder where to find the scripts to install.
F="/Users/oscar/Library/CloudStorage/Dropbox/feenk/gt-files"

# Timestamp for the build folder.
date=`date "+%Y-%m-%d@%Hh%M"`
gt="GT-${date}"
tmp=tmp$$

trap "echo EXIT;  exit" 0
trap "echo HUP;   exit" 1
trap "echo CTL-C; exit" 2
trap "echo QUIT;  exit" 3
trap "echo ERR;   exit" ERR

echo "Creating $gt"

# Temporary folder for the build.
mkdir $tmp
cd $tmp

# Download and run the installer script.
time curl https://dl.feenk.com/scripts/mac.sh | bash

# ALT: Build *without* opening GT World
# curl -LsS https://github.com/feenkcom/gtoolkit-maestro-rs/releases/latest/download/installer.sh > installer.sh
# chmod 0755 installer.sh
# time ./installer.sh local-build --no-gt-world
# exit

# Move the build to its final location.
cd ..
mv $tmp/glamoroustoolkit $gt
rm -rf $tmp

# Generate a command file to start up GT. (On Mac you can double-click the file.)
# NB: 1. This will open a Terminal which will display any diagnostics. In case of serious problems, save the Terminal output.
# 2. The script increases the number of open files allowed with ulimit.
run="$gt/__startGt.command"
cat > "$run" <<'eof'
#! /bin/sh
D=`dirname "$0"`
cd "$D"
ulimit -n 10240
./GlamorousToolkit.app/Contents/MacOS/GlamorousToolkit \
  --image GlamorousToolkit.image
eof
chmod 0755 "$run"

# Generate a command file to debug GT
debug="$gt/__debugGt.command"
cat > "$debug" <<'eof'
#! /bin/sh
D=`dirname "$0"`
cd "$D"
ulimit -n 10240
codesign --force --deep --sign - GlamorousToolkit.app
lldb ./GlamorousToolkit.app/Contents/MacOS/GlamorousToolkit-cli
exit
# Then in lldb:
run GlamorousToolkit.image --interactive
eof
chmod 0755 "$debug"

# Generate an alias that will appear near the top of the current directory.
# If you have lots of builds, delete the aliases you don't need.
ln -s "$gt" "__$gt"

# Copy scripts to add to the build.
# makeAliases will generate startup scripts for projects that you are working on.
# cp "$F/makeAliases.command" "$gt/__makeAliases.command"
# startup.st is s Smalltalk script of things to run when you start an image.
cp "$F/startup.st" "$gt"

# Backup the build as a zip file.
echo zip -q -y -r "$gt.zip" "$gt"
zip -q -y -r "$gt.zip" "$gt"

exit
