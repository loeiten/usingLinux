#!/bin/bash

# Installs fftw
FFTW_VERSION="3.3.6-pl2"

# exit on error
set -e

# Install fftw
echo -e "\n\n\nInstalling fftw\n\n\n"
cd $HOME
mkdir -p local
cd local
mkdir -p examples
cd ..
mkdir -p install
cd install
wget http://www.fftw.org/fftw-${FFTW_VERSION}.tar.gz
tar -xzvf fftw-${FFTW_VERSION}.tar.gz
cd fftw-${FFTW_VERSION}
./configure --prefix=$HOME/local
make
make install
echo -e "\n\n\nDone installing fftw\n\n\n"
