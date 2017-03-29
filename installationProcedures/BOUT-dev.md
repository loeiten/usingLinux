# Installation of BOUT-dev

**NOTE**: An installation script can be found [here](../installScripts/boutPPInstall.sh).
...through own experience

- [Install MPI](#install-mpi)
- [Installation of optional external libraries](#installation-of-optional-external-libraries)
    - [Install Sundials](#install-sundials)
    - [Install PETSc](#install-petsc)
    - [Install SLEPc](#install-slepc)
- [BOUT-dev installation](#bout-dev-installation)
    - [BOUT-dev installation on laptop](#bout-dev-installation-on-laptop)
    - [BOUT-dev installation on jess](#bout-dev-installation-on-jess)

**NOTE**:

1. This note is written for BOUT-dev 4.0.
2. It is highly recommended to clone from the [BOUT-dev](https://github.com/boutproject/BOUT-dev) repository.

## Install MPI

### Check installation
Test

```
mpicc
```

this should give something like

```
Error: Command line argument is needed!
Usage: mpicc [options] file....
```

if so, then skip the [Install](#install) part. If on the other hand you get
something like

```
mpicc: command not found
```

then continue with the steps below.


### Install

Do not install mpi in the way described in the manual, as this can give rise to
several mpi binaries (this will result in all processors giving processor nr 0).
Instead install through [conda](python.md)

```
conda install mpich2
```

Alternative, download mpich-3.1.4 and

```
./configure --prefix=$HOME/local CC=gcc CXX=g++ FC=gfortran && make && make install
```


## Installation of optional external libraries

Installation of these are optional, but recommended.

### Install Sundials

At the time of writing, sundials can be obtained by

```
cd ~
mkdir -p local
cd local
mkdir -p examples
cd ..
mkdir -p install
cd install
wget http://computation.llnl.gov/projects/sundials-suite-nonlinear-differential-algebraic-equation-solvers/download/sundials-2.6.2.tar.gz
tar -xzvf sundials-2.6.2.tar.gz
rm sundials-2.6.2.tar.gz
cd sundials-2.6.2
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
```

but be aware that the url will probably change as new versions will come.

### Install PETSc

Currently PETSc-3.4.5 is working nicely.

Before you start you may have to install `gfortran` (this is usually installed
on the clusters)

```
sudo apt-get install gfortran
```

continue with

```
cd ~
wget http://ftp.mcs.anl.gov/pub/petsc/release-snapshots/petsc-3.4.5.tar.gz
tar -xzvf petsc-3.4.5.tar.gz
rm petsc-3.4.5.tar.gz
cd petsc-3.4.5
python2 ./configure \
--with-clanguage=cxx \
--with-mpi=1 \
--with-precision=double \
--with-scalar-type=real \
--with-shared-libraries=0 \
--download-fblaslapack=1 \
--download-f2cblaslapack=1
```

Check that everything works, if not, it could be that downloading additional
libraries with PETSc can help. See BOUT's user manual for more info.

```
make PETSC_DIR=$HOME/petsc-3.4.5 PETSC_ARCH=arch-linux2-cxx-debug all
```

Testing

```
make PETSC_DIR=$HOME/petsc-3.4.5 PETSC_ARCH=arch-linux2-cxx-debug test
```

Add the following line to your `.bashrc`:

```
export PETSC_DIR=$HOME/petsc-3.4.5
```

Run the same command in your shell.


### Install SLEPc

`PETSc` must be installed with the following written in the `.bashrc`

```
export PETSC_DIR=$HOME/petsc-3.4.5
export PETSC_ARCH=arch-linux2-cxx-debug
export SLEPC_DIR=$HOME/slepc-3.4.4
```

The same commands must be written in the terminal. Installation can now be done
with

```
cd ~
wget http://slepc.upv.es/download/download.php?filename=slepc-3.4.4.tar.gz -O slepc-3.4.4.tar.gz
tar xzf slepc-3.4.4.tar.gz
rm slepc-3.4.4.tar.gz
cd slepc-3.4.4
python2 ./configure
```
Check that everything works
```
make SLEPC_DIR=$PWD PETSC_DIR=/home/mmag/petsc-3.4.4 PETSC_ARCH=arch-linux2-cxx-debug
make test
```


## BOUT-dev installation

###  BOUT-dev installation on laptop

#### Preparations
```
sudo apt-get install libfftw3-dev libnetcdf-cxx-legacy-dev
```
if this doesn't work, try
```
sudo apt-get install libfftw3-dev libnetcdf-dev
```
but note that the file `netcdfcpp.h` seems to be missing from newer versions.

install netcdf4 through [conda](python.md)

**NOTE**: `netcdf4` version `1.2.2` can give

```
WARNING: netcdf4-python module not found
         expect poor performance
           => Using scipy.io.netcdf instead
```

`netcdf4` version `1.2.1` seem to work  (install with `conda install netcdf4=1.2.1`)

* Install [Sundials](#install-sundials)
* Install [PETSc](#install-petsc)
* Install [SLEPc](#install-slepc)



#### Configure BOUT-dev
cd into the BOUT-dev folder

```
./configure --enable-checks=3 --enable-track --enable-debug --with-petsc --with-slepc --with-sundials
make
cd examples/bout_runners_example
python 6a-run_with_MMS_post_processing_specify_numbers.py
```

A known issue is

```
./3D_diffusion: $HOME/anaconda3/lib/libgfortran.so.3: version 'GFORTRAN_1.4' not found (required by ./3D_diffusion)
```

Note that this probably doesn't occur if you are not building with PETSc.
A workaround is to bypass the anaconda libfortran (which comes from the scipy
package). Putting this to the .bashrc file helps

```
export LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libgfortran.so.3
```

**NOTE**: One need to address the correct path here. Other suggestion include
downloading the scipy library to 0.16.0
https://github.com/ContinuumIO/anaconda-issues/issues/686

### BOUT-dev installation on jess

#### Installation of `fftw`

In the terminal, run

```
cd ~
mkdir -p local
cd local
mkdir -p examples
cd ..
mkdir -p install
cd install
wget http://www.fftw.org/fftw-3.3.5.tar.gz
tar -xzvf fftw-3.3.5.tar.gz
cd fftw-3.3.5
./configure --prefix=$HOME/local
make
make install
```

#### Installation of `hdf5`
In the terminal, run

```
mkdir -p local
cd local
mkdir -p examples
cd ..
mkdir -p install
cd install
wget ftp://ftp.hdfgroup.org/HDF5/current/src/hdf5-1.10.0-patch1.tar.gz
tar -xzvf hdf5-1.10.0-patch1.tar.gz
cd hdf5-1.10.0-patch1
./configure --prefix=$HOME/local
make
make install
```

#### Installation of `netcdf`

netcdf requires [hdf5](#installation-of-hdf5-4.4.1.1)
In the terminal, run

```
cd ~
mkdir -p local
cd local
mkdir -p examples
cd ..
mkdir -p install
cd install
wget http://www.unidata.ucar.edu/downloads/netcdf/ftp/netcdf-4.4.1.1.tar.gz
tar -xzvf netcdf-4.4.1.1.tar.gz
cd netcdf-4.4.1.1
CPPFLAGS=-I$HOME/local/include LDFLAGS=-L$HOME/local/lib ./configure --prefix=$HOME/local --disable-dap
make
make check
make install

cd $HOME/install
wget -O netcdf-cxx4-4.3.0.tar.gz http://github.com/Unidata/netcdf-cxx4/archive/v4.3.0.tar.gz
tar -xzvf netcdf-cxx4-4.3.0.tar.gz
cd netcdf-cxx4-4.3.0
CPPFLAGS=-I$HOME/local/include LDFLAGS=-L${NETCDFDIR}/lib ./configure --prefix=$HOME/local
make
make check
make install
```

Add

```
export PATH="$HOME/local/bin:$PATH"
export LD_LIBRARY_PATH=$HOME/local/lib:$LD_LIBRARY_PATH
```

to your `~/.bashrc`

#### Configure BOUT-dev

If you want `sundials` and `PETSc`, see

* Install [Sundials](#install-sundials)
* Install [PETSc](#install-petsc)
* Install [SLEPc](#install-slepc)

cd into the BOUT-dev folder

```
./configure --enable-checks=no --with-fftw --with-netcdf --with-petsc --with-slepc --with-sundials --enable-optimize=3
make clean && make
cd examples/bout_runners_example
python 9-PBS_with_MMS_post_processing_grid_file.py
```

This should run without problems

**NOTE**: `netcdf4` version `1.2.2` can give

```
WARNING: netcdf4-python module not found
         expect poor performance
           => Using scipy.io.netcdf instead
```

`netcdf4` version `1.2.1` seem to work (install with `conda install netcdf4=1.2.1`)
