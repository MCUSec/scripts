#!/bin/bash

if [ ! -d "../build" ]; then
	mkdir -p ../build
fi

if [ ! -f "/usr/include/x86_64-linux-gnu/asm/ptracearm.h" ]; then
	sudo cp misc/ptracearm.h /usr/include/x86_64-linux-gnu/asm
fi

# Install dependencies

sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get -y install build-essential cmake wget texinfo flex bison	\
		python-dev python3-dev python3-venv python3-distro mingw-w64 lsb-release
sudo apt-get -y install libdwarf-dev libelf-dev libelf-dev:i386 libelf-dev   	\
			libboost-dev zlib1g-dev libjemalloc-dev nasm pkg-config libglib2.0-dev  \
			libmemcached-dev libpq-dev libc6-dev-i386 binutils-dev libncurses5 	\
			libboost-system-dev libboost-serialization-dev libboost-regex-dev     	\
			libbsd-dev libpixman-1-dev  git libpng-dev  python3-docutils            	\
			libglib2.0-dev libglib2.0-dev:i386 gcc-multilib g++-multilib binutils-dev libboost-dev
sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt-get update
sudo apt-get install -y software-properties-common gcc-9 g++-9

# Build & Install

chmod +x ../s2e-ratava/libs2e/configure
cd ../build
make -f ../Makefile && make -f ../Makefile install

# finalize

cd ..
cp misc/library.lua misc/uEmu-config.lua misc/launch-uEmu.sh .

