#!/usr/bin/env bash

# Installs mpi
MPI_VERSION="3.2"

# exit on error
set -e

# Install mpi
echo -e "\n\n\nInstalling mpi\n\n\n"
cd $HOME
mkdir -p local
cd local
mkdir -p examples
cd ..
mkdir -p install
cd install
wget http://www.mpich.org/static/downloads/${MPI_VERSION}/mpich-${MPI_VERSION}.tar.gz
tar -xzvf mpich-${MPI_VERSION}.tar.gz

cd mpich-${MPI_VERSION}
# : is the no-op command
make clean || :
./configure --prefix=$HOME/local
make
make install
echo -e "\n\n\nDone installing mpi\n\n\n"
