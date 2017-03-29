#!/bin/bash

# Installs sundials
# SUNDIALS_VERSION="2.7.0" # Gives openmp problems
SUNDIALS_VERSION="2.6.2"

# exit on error
set -e

# Install sudials
echo -e "\n\n\nInstalling sundials\n\n\n"
cd $HOME
mkdir -p local
cd local
mkdir -p examples
cd ..
mkdir -p install
cd install
wget http://computation.llnl.gov/projects/sundials-suite-nonlinear-differential-algebraic-equation-solvers/download/sundials-${SUNDIALS_VERSION}.tar.gz
tar -xzvf sundials-${SUNDIALS_VERSION}.tar.gz
rm sundials-${SUNDIALS_VERSION}.tar.gz
cd sundials-${SUNDIALS_VERSION}
mkdir -p build
cd build
cmake \
-DCMAKE_INSTALL_PREFIX=$HOME/local \
-DEXAMPLES_INSTALL_PATH=$HOME/local/examples \
-DOPENMP_ENABLE=ON \
-DMPI_ENABLE=ON \
-DCMAKE_LINKER=$HOME/local/lib \
-DBUILD_SHARED_LIBS=OFF \
../
make
make install

echo -e "\n\n\nDone installing sundials\n\n\n"
