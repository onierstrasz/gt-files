# Makefile for GT VM on Intel Mac

GIT=git@github.com:feenkcom/gtoolkit-vm.git
TARGET=x86_64-apple-darwin
DIR=gtoolkit-vm

build : gtoolkit-vm pull compile
	
gtoolkit-vm :
	git clone $(GIT)
	cd $(DIR); git submodule update --init --recursive
	cd $(DIR); git submodule update --remote --recursive

pull : $(DIR)
	cd $(DIR); git pull

# Install intel-specific builder

compile :
	cd $(DIR); \
	curl -o gtoolkit-vm-builder -LsS https://github.com/feenkcom/gtoolkit-vm-builder/releases/latest/download/gtoolkit-vm-builder-$(TARGET); \
	chmod +x gtoolkit-vm-builder; \
	./gtoolkit-vm-builder build \
    --release \
    --app-name 'GlamorousToolkit' \
    --identifier 'com.gtoolkit' \
    --author "feenk gmbh <contact@feenk.com>" \
    --libraries-versions libraries.version \
    --libraries clipboard filewatcher gleam glutin pixels process skia webview winit winit30 test-library cairo crypto freetype git sdl2 ssl

# Use `compile` to only build executables and third-party libraries, `bundle` to package already compiled artifacts, or `build` to run both steps.

clean :
	-rm -rf $(DIR)

# Install Rust and cmake
rust :
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

cmake :
	brew install cmake
