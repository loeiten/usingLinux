#!/bin/bash

# Installs the master branch of BOUT-dev
INCL_PETSC_SLEPC=false
INCL_SUNDIALS=true
OPTIMIZING=true
DEBUG=false

# exit on error
set -e

CURDIR=$PWD
EXTRA_PACKAGES=""
EXTRA_FLAGS=""

if [ OPTIMIZING=true ]; then
    EXTRA_FLAGS="${EXTRA_FLAGS} --enable-checks=no --enable-optimize=3"
elif [ DEBUG=true ]; then
    EXTRA_FLAGS="${EXTRA_FLAGS} --enable-debug --enable-checks=3 --enable-track"
fi

# Requires anaconda
cd $HOME
ANACONDA=`find anaconda* -print -quit`
if [ ! -d $ANACONDA ]; then
    echo -e "\nThe installation script requires anaconda installed in ${HOME}"
    exit 1
fi

# Install mpich2
echo -e "\n\n\nInstalling mpich2 through anaconda\n\n\n"
echo "Y" | conda install mpich2

export PATH="$HOME/local/bin:$PATH"
export LD_LIBRARY_PATH=$HOME/local/lib:$LD_LIBRARY_PATH

# # Install fftw
bash $CURDIR/fftwInstall.sh

# Install hdf5
bash $CURDIR/hdf5Install.sh

# Install netcdf
bash $CURDIR/netcdfInstall.sh

if [ INCL_SUNDIALS=true ]; then
    # Install sudials
    bash $CURDIR/sundialsInstall.sh
    EXTRA_PACKAGES="${EXTRA_PACKAGES} --with-sundials"
fi

if [ INCL_PETSC_SLEPC=true ]; then
    # Install PETSc
    bash $CURDIR/PETScInstall.sh

    # Install SLEPc
    bash $CURDIR/SLEPcInstall.sh
    EXTRA_PACKAGES="${EXTRA_PACKAGES} --with-petsc --with-slepc"
fi

echo -e "\n\n\nInstalling BOUT-dev\n\n\n"
cd $HOME
git clone https://github.com/boutproject/BOUT-dev.git
cd BOUT-dev
./configure ${EXTRA_FLAGS} ${EXTRA_PACKAGES}
make
echo -e "\n\n\nDone installing BOUT-dev\n\n\n"
echo -e "\n\n\nChecking installation\n\n\n"
cd examples/conduction
make
./conduction

echo -e "\n\n\nInstallation complete.\n"
echo -e "Make sure the following lines are present in your .bashrc:"
echo -e "export PYTHONPATH=\$HOME/BOUT-dev/tools/pylib/:\$PYTHONPATH"
echo -e "export PATH=\$HOME/local/bin:\$PATH"
echo -e "export LD_LIBRARY_PATH=\$HOME/local/lib:\$LD_LIBRARY_PATH"

if [ INCL_PETSC_SLEPC=true ]; then
    echo -e "export PETSC_DIR=\$HOME/petsc-\${PETSC_VERSION}"
    echo -e "export PETSC_ARCH=arch-linux2-cxx-debug"
    echo -e "export SLEPC_DIR=\$HOME/slepc-\${SLEPC_VERSION}"
fi
