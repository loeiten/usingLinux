#!/bin/bash

# Installs netcdf
NETCDF_VERSION="4.4.1.1"
NETCDF_CXX_VERSION="4.3.0"
H5DIR="$HOME/local"
NETCDFDIR="$HOME/local"

# exit on error
set -e

# Install netcdf
echo -e "\n\n\nInstalling netcdf\n\n\n"
cd $HOME
mkdir -p local
cd local
mkdir -p examples
cd ..
mkdir -p install
cd install
wget http://www.unidata.ucar.edu/downloads/netcdf/ftp/netcdf-${NETCDF_VERSION}.tar.gz
tar -xzvf netcdf-${NETCDF_VERSION}.tar.gz
cd netcdf-${NETCDF_VERSION}
# NOTE:
# netCDF-4 doesn't use --with-PACKAGE=PATH
# https://www.unidata.ucar.edu/support/help/MailArchives/netcdf/msg13261.html
# http://www.unidata.ucar.edu/software/netcdf/docs/getting_and_building_netcdf.html#build_default
# --disable-dap can be removed if libcurl is accessible
CPPFLAGS=-I${H5DIR}/include LDFLAGS=-L${H5DIR}/lib ./configure --prefix=$HOME/local --disable-dap
make
make check
make install
echo -e "\n\n\nDone installing netcdf\n\n\n"

# Install c++ api
echo -e "\n\n\nInstalling the c++ interface\n\n\n"
cd $HOME/install
wget -O netcdf-cxx4-${NETCDF_CXX_VERSION}.tar.gz http://github.com/Unidata/netcdf-cxx4/archive/v${NETCDF_CXX_VERSION}.tar.gz
tar -xzvf netcdf-cxx4-${NETCDF_CXX_VERSION}.tar.gz
cd netcdf-cxx4-${NETCDF_CXX_VERSION}
CPPFLAGS=-I${NETCDFDIR}/include LDFLAGS=-L${NETCDFDIR}/lib ./configure --prefix=$HOME/local
make
make check
make install
echo -e "\n\n\nDone installing the c++ interface\n\n\n"
