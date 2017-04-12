#!/usr/bin/env bash

# Installs hdf5
HDF5_VERSION="1.10.0-patch1"

# exit on error
set -e

# Install hdf5
echo -e "\n\n\nInstalling hdf5\n\n\n"
cd $HOME
mkdir -p local
cd local
mkdir -p examples
cd ..
mkdir -p install
cd install
wget ftp://ftp.hdfgroup.org/HDF5/current/src/hdf5-${HDF5_VERSION}.tar.gz
tar -xzvf hdf5-${HDF5_VERSION}.tar.gz
cd hdf5-${HDF5_VERSION}
# : is the no-op command
make clean || :
./configure --prefix=$HOME/local --enable-cxx=yes
make
make install
echo -e "\n\n\nDone installing hdf5\n\n\n"
