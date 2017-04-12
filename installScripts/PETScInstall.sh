#!/usr/bin/env bash

# Installs PETSc
PETSC_VERSION="3.4.5"

# exit on error
set -e

# Install PETSc
echo -e "\n\n\nInstalling PETSc\n\n\n"
cd $HOME
wget http://ftp.mcs.anl.gov/pub/petsc/release-snapshots/petsc-${PETSC_VERSION}.tar.gz
tar -xzvf petsc-${PETSC_VERSION}.tar.gz
rm petsc-${PETSC_VERSION}.tar.gz
cd petsc-${PETSC_VERSION}
python2 ./configure \
--with-clanguage=cxx \
--with-mpi=1 \
--with-precision=double \
--with-scalar-type=real \
--with-shared-libraries=0 \
--download-fblaslapack=1 \
--download-f2cblaslapack=1
# : is the no-op command
make clean || :
make PETSC_DIR=$HOME/petsc-${PETSC_VERSION} PETSC_ARCH=arch-linux2-cxx-debug all
make PETSC_DIR=$HOME/petsc-${PETSC_VERSION} PETSC_ARCH=arch-linux2-cxx-debug test

export PETSC_DIR=$HOME/petsc-${PETSC_VERSION}
export PETSC_ARCH=arch-linux2-cxx-debug
echo -e "\n\n\nDone installing PETSc\n\n\n"
