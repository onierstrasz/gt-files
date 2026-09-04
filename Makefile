# Makefile for GT VM on Intel Mac

# NOT WORKING -- we are currently missing the Winit library

GIT=git@github.com:feenkcom/gtoolkit-vm.git
TARGET=x86_64-apple-darwin
GTVMDIR=gtoolkit-vm

ZIP=GlamorousToolkit-x86_64-apple-darwin.app.zip
INSTALLER=gt-installer
VM=GlamorousToolkit.app
GT=glamoroustoolkit
RUN=__startGt.command
DATE=$(shell date "+%Y-%m-%d@%Hh%M" )
BACKUP="GT-$(DATE)"

build : vm glamoroustoolkit run backup

glamoroustoolkit :
	curl -o "$(INSTALLER)" -L -s -S "https://github.com/feenkcom/gtoolkit-maestro-rs/releases/latest/download/$(INSTALLER)-x86_64-apple-darwin" > /dev/null
	chmod +x "$(INSTALLER)"
	PWD=`pwd`
	./$(INSTALLER) --app-cli-binary $(PWD)/$(VM)/Contents/MacOS/GlamorousToolkit-cli local-build

# Assumes we have __startGt.command
# #! /bin/sh
# D=`dirname "$0"`
# cd "$D"
# ulimit -n 10240
# ./GlamorousToolkit.app/Contents/MacOS/GlamorousToolkit \
#   --image GlamorousToolkit.image
run :
	cp ./$(RUN) $(GT)
	chmod +x $(GT)/$(RUN)
	rm -rf $(GT)/$(VM)
	cp -r $(VM) $(GT)
	chmod +x $(GT)/$(VM)

# Instead of building the VM we download it
vm : GlamorousToolkit.app

GlamorousToolkit.app :
	curl -LsS -O https://github.com/feenkcom/gtoolkit-vm/releases/download/v1.1.67/$(ZIP)
	unzip $(ZIP)
	chmod +x ./$@

backup :
	mv $(GT) $(BACKUP)
	zip -q -y -r "$(BACKUP).zip" "$(BACKUP)"

clean :
	-rm -rf $(ZIP) $(INSTALLER) $(VM)
	-rm -rf install-errors.log install.log
	-rm -rf $(GTVMDIR)

file.txt :
	cat << eof > $@
	#! /bin/sh
	D=`dirname "$0"`
	cd "$D"
	ulimit -n 10240
	./GlamorousToolkit.app/Contents/MacOS/GlamorousToolkit \
	  --image GlamorousToolkit.image
	eof

# ---- OLD STUFF TRYING TO BUILD THE VM

oldBuild : gtoolkit-vm pull compile
	
gtoolkit-vm :
	git clone $(GIT)
	cd $(GTVMDIR); git submodule update --init --recursive
	cd $(GTVMDIR); git submodule update --remote --recursive

pull : $(GTVMDIR)
	cd $(GTVMDIR); git pull

# Install intel-specific builder

compile :
	cd $(GTVMDIR); \
	curl -o gtoolkit-vm-builder -LsS https://github.com/feenkcom/gtoolkit-vm-builder/releases/latest/download/gtoolkit-vm-builder-$(TARGET); \
	chmod +x gtoolkit-vm-builder; \
	./gtoolkit-vm-builder build \
    --release \
    --app-name 'GlamorousToolkit' \
    --identifier 'com.gtoolkit' \
    --author "feenk gmbh <contact@feenk.com>" \
    --libraries-versions libraries.version \
    --libraries clipboard filewatcher pixels process skia webview winit30 cairo crypto freetype git ssl

# Use `compile` to only build executables and third-party libraries, `bundle` to package already compiled artifacts, or `build` to run both steps.

# Install Rust and cmake
rust :
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

cmake :
	brew install cmake
