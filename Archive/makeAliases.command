#! /bin/sh
#
# Caveat -- no longer used.
#
# Create aliases and start commands for images with given repos loaded.
# Put this in a newly created GT folder and run it.
#
# The script assumes that when you load a given repo, say
#  https://github.com/ghUser/ghProject
# that you will save the image as "ghProject.image".
# It will look for such an image and generate the startup command.
#
# Oscar Nierstrasz 2023-01-10
# https://creativecommons.org/licenses/by/4.0/
#
# https://github.com/onierstrasz/gt-startup/tree/main/gt-files

# This directory. Should be where the GT images are.
D=`dirname "$0"`
cd "$D"

# --------------------------------------------------------------------------------
# Generate a startup command for $1.image, if it exists.
makeStartCmd () {
	C="_start-$1.command"
	if test -e "$1.image"
	then
		if test ! -e "$C"
		then
			cat > "$C" <<eof
#! /bin/sh
cd `dirname "$0"`
ulimit -n 10240
./GlamorousToolkit.app/Contents/MacOS/GlamorousToolkit --image $1.image
eof
			echo "Created $C"
			chmod 0755 "$C"
		fi
	fi
}
# --------------------------------------------------------------------------------
# Look for a cloned repo where $1=ghUser and $2=ghProject
# If it exists, create an alias in the current directory to the cloned repo,
# and generate the startup command script.
link () {
	R="${D}/pharo-local/iceberg/$1/$2"
	if test -d "$R"
	then
		if test ! -e "_$2"
		then
			ln -s "$R" "_$2"
			echo "Linked _$2"
			makeStartCmd "$2"
		fi
	fi
}
# --------------------------------------------------------------------------------

# The main body -- configure this part for the projects you work on.
# Run just `makeStartCmd gtProject` if you  just want to build a startup script.
# Run `link ghUser ghProject` if you want to also generate an alias to the repo.

makeStartCmd gtbook

link onierstrasz gt-startup

link RowITLou SES_KanbanProject

link feenkcom gt4DrGeo
link feenkcom gtoolkit-shorts
link feenkcom gt4sudoku
link feenkcom yaml-parser
link feenkcom gtoolkit-demos
link feenkcom db-modelcards

link pavt workflow-evolution
link pavt egad

link onierstrasz AOC2023
link onierstrasz GtKatas
link onierstrasz gt-demos
link onierstrasz gt-talks
link onierstrasz zest-demo
link onierstrasz HomeAdmin
link onierstrasz esugWebsite

link scgbern scgpico

link bergel GeneticallyCreatedTests

exit
# --------------------------------------------------------------------------------

