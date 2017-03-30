#!/bin/bash

# NOTE: Depends on PETSc

# Installs SLEPc
SLEPC_VERSION="3.4.4"
PETSC_VERSION="3.4.5"

# exit on error
set -e

export SLEPC_DIR=$HOME/slepc-${SLEPC_VERSION}

echo -e "\n\n\nInstalling SLEPc\n\n\n"
cd $HOME
wget http://slepc.upv.es/download/download.php?filename=slepc-${SLEPC_VERSION}.tar.gz -O slepc-${SLEPC_VERSION}.tar.gz
tar xzf slepc-${SLEPC_VERSION}.tar.gz
rm slepc-${SLEPC_VERSION}.tar.gz
cd slepc-${SLEPC_VERSION}
python2 ./configure
make SLEPC_DIR=$HOME/slepc-${SLEPC_VERSION} PETSC_DIR=$HOME/petsc-${PETSC_VERSION} PETSC_ARCH=arch-linux2-cxx-debug
make test
echo -e "\n\n\nDone installing SLEPc\n\n\n"
