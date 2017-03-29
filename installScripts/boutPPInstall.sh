#!/bin/bash

# Installs the master branch of BOUT-dev
SUNDIALS_VERSION="2.7.0"
INCL_PETSC_SLEPC=false
PETSC_VERSION="3.4.5"
SLEPC_VERSION="3.4.4"

# exit on error
set -e

# Requires anaconda
cd $HOME
ANACONDA=`find anaconda* -print -quit`
if [ -d $ANACONDA ]; then
    echo -e "\nThe installation script requires anaconda installed in ${HOME}"
    exit 1
fi

# Install mpich2
echo -e "\n\n\nInstalling mpich2 through anaconda\n\n\n"
echo "Y" | conda install mpich2

# Install sudials
echo -e "\n\n\nInstalling sundials\n\n\n"
cd $HOME
mkdir -p local
cd local
mkdir examples
cd ..
mkdir install
cd install
wget http://computation.llnl.gov/projects/sundials-suite-nonlinear-differential-algebraic-equation-solvers/download/sundials-${SUNDIALS_VERSION}.tar.gz
tar -xzvf sundials-${SUNDIALS_VERSION}.tar.gz
rm sundials-${SUNDIALS_VERSION}.tar.gz
cd sundials-${SUNDIALS_VERSION}
mkdir build
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

if [ INCL_PETSC_SLEPC = true ]; then
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

    export PETSC_DIR=$HOME/petsc-${PETSC_VERSION}

    echo -e "\n\n\nInstalling SLEPc\n\n\n"

    export PETSC_ARCH=arch-linux2-cxx-debug
    export SLEPC_DIR=$HOME/slepc-${SLEPC_VERSION}

    cd $HOME
    wget http://slepc.upv.es/download/download.php?filename=slepc-${SLEPC_VERSION}.tar.gz -O slepc-${SLEPC_VERSION}.tar.gz
    tar xzf slepc-${SLEPC_VERSION}.tar.gz
    rm slepc-${SLEPC_VERSION}.tar.gz
    cd slepc-${SLEPC_VERSION}
    python2 ./configure
fi

echo -e "\n\n\nInstallation complete.\n"
echo -e "Add the following line to your .bashrc:"
echo -e "export PETSC_DIR=$HOME/petsc-${PETSC_VERSION}"
echo -e "export PETSC_ARCH=arch-linux2-cxx-debug"
echo -e "export SLEPC_DIR=$HOME/slepc-${SLEPC_VERSION}"
