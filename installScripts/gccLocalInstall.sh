#!/bin/bash

# Installs GCC locally
# This based on http://luiarthur.github.io/gccinstall
# NOTE: The installation usually takes long time

VERSION="6.1.0"

# exit on error
set -e

mkdir -p $HOME/install
cd $HOME/install

echo -e "\n\n\n\n\n Downloading gcc version ${VERSION}\n"
wget ftp://ftp.fu-berlin.de/unix/languages/gcc/releases/gcc-${VERSION}/gcc-${VERSION}.tar.gz

echo -e "\n\n\n\n\n Extracting\n"
tar xzf gcc-${VERSION}.tar.gz
cd gcc-${VERSION}

echo -e "\n\n\n\n\n Downloading prerequisites\n"
./contrib/download_prerequisites
cd ..
mkdir -p objdir
cd objdir

echo -e "\n\n\n\n\n Configuring gcc\n"
$PWD/../gcc-{$VERSION}/configure --prefix=$HOME/gcc-${VERSION}


echo -e "\n\n\n\n\n Making\n"
make

echo -e "\n\n\n\n\n Make install\n"
make install

echo -e "\n\n\n\n\n Success!\n"
