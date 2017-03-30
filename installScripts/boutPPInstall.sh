#!/bin/bash

# Installs the master branch of BOUT-dev
# CMAKE above 2.8.11
INSTALL_CMAKE="true"
INCL_PETSC_SLEPC="false"
INCL_SUNDIALS="true"
OPTIMIZING="true"
DEBUG="false"

# exit on error
set -e

CURDIR=$PWD
EXTRA_PACKAGES=""
EXTRA_FLAGS=""

if [ "$OPTIMIZING" = "true" ]; then
    EXTRA_FLAGS="${EXTRA_FLAGS} --enable-checks=no --enable-optimize=3"
elif [ "$DEBUG" = "true" ]; then
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
echo "y" | conda install mpich2
echo -e "\n\n\nDone installing mpich2\n\n\n"
# Install hdf4 to avoid "WARNING: netcdf4-python module not found"
echo -e "\n\n\nInstalling hdf4 through anaconda\n\n\n"
echo "y" | conda install hdf4
echo -e "\n\n\nDone installing hdf4\n\n\n"
# Install netcdf4
echo -e "\n\n\nInstalling netcdf4 through anaconda\n\n\n"
echo "y" | conda install netcdf4
echo -e "\n\n\nDone installing netcdf4\n\n\n"

export PATH="$HOME/local/bin:$PATH"
export LD_LIBRARY_PATH=$HOME/local/lib:$LD_LIBRARY_PATH

if [ "$INSTALL_CMAKE" = "true" ]; then
    # Install sudials
    bash $CURDIR/cmakeInstall.sh
fi
# Install fftw
bash $CURDIR/fftwInstall.sh

# Install hdf5
bash $CURDIR/hdf5Install.sh

# Install netcdf
bash $CURDIR/netcdfInstall.sh

if [ "$INCL_SUNDIALS" = "true" ]; then
    # Install sudials
    bash $CURDIR/sundialsInstall.sh
    EXTRA_PACKAGES="${EXTRA_PACKAGES} --with-sundials"
fi


if [ "$INCL_PETSC_SLEPC" = true ]; then
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
# FIXME:
# NOTE: Explicilty state netcdf and hdf5 in order not to mix with anaconda
# ./configure ${EXTRA_FLAGS} ${EXTRA_PACKAGES} --with-netcdf=$HOME/local/bin/nc-config --with-hdf5=$HOME/local/bin/h5cc
./configure ${EXTRA_FLAGS} ${EXTRA_PACKAGES}
make
echo -e "\n\n\nDone installing BOUT-dev\n\n\n"
echo -e "\n\n\nChecking installation\n\n\n"
cd examples/bout_runners_example
make
python 6a-run_with_MMS_post_processing_specify_numbers.py

echo -e "\n\n\nInstallation complete.\n"
echo -e "Make sure the following lines are present in your .bashrc:"
echo -e "export PYTHONPATH=\$HOME/BOUT-dev/tools/pylib/:\$PYTHONPATH"
echo -e "export PATH=\$HOME/local/bin:\$PATH"
echo -e "export LD_LIBRARY_PATH=\$HOME/local/lib:\$LD_LIBRARY_PATH"

if [ "$INCL_PETSC_SLEPC" = true ]; then
    echo -e "export PETSC_DIR=\$HOME/petsc-\${PETSC_VERSION}"
    echo -e "export PETSC_ARCH=arch-linux2-cxx-debug"
    echo -e "export SLEPC_DIR=\$HOME/slepc-\${SLEPC_VERSION}"
fi
