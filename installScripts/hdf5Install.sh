#!/usr/bin/env bash

# Installs hdf5
HDF5_MAJOR="1"
HDF5_MINOR="10"
HDF5_PATCH="1"

# exit on error
set -e

HDF5_MAJOR_MINOR=${HDF5_MAJOR}.${HDF5_MINOR}
HDF5_VERSION=${HDF5_MAJOR_MINOR}.${HDF5_PATCH}

# Install hdf5
echo -e "\n\n\nInstalling hdf5\n\n\n"
cd $HOME
mkdir -p local
cd local
mkdir -p examples
cd ..
mkdir -p install
cd install
wget ftp://ftp.hdfgroup.org/HDF5/releases/hdf5-${HDF5_MAJOR_MINOR}/hdf5-${HDF5_VERSION}/src/hdf5-${HDF5_VERSION}.tar.gz
tar -xzvf hdf5-${HDF5_VERSION}.tar.gz
cd hdf5-${HDF5_VERSION}
# : is the no-op command
make clean || :
./configure --prefix=$HOME/local --enable-cxx=yes
make
make install
echo -e "\n\n\nDone installing hdf5\n\n\n"
