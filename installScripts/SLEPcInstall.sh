#!/bin/bash

# NOTE: Depends on PETSc

# Installs SLEPc
SLEPC_VERSION="3.4.4"

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
echo -e "\n\n\nDone installing SLEPc\n\n\n"
