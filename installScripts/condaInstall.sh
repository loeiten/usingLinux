#!/usr/bin/env bash

# exit on error
set -e

# Installs conda
echo -e "\n\n\nInstalling conda\n\n\n"
cd $HOME
mkdir -p install
cd install
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh
bash miniconda.sh -b -p $HOME/anaconda3

export PATH="$HOME/anaconda3/bin:$PATH"

conda config --set always_yes yes --set changeps1 no
# NOTE: Update before installing hdf4, as hdf-4.2.12 is needed
conda update --all
# Install hdf4 to avoid "WARNING: netcdf4-python module not found"
conda install numpy scipy hdf4 netcdf4 matplotlib sympy pandas
# Reverting to check
conda config --set always_yes no

export PATH="$HOME/anaconda3/bin:$PATH"
echo -e "\n\n\nDone installing conda\n\n\n"
echo "Please add"
echo "export PATH=\"$HOME/anaconda3/bin:$PATH\""
echo "To your ~/.bashrc"
