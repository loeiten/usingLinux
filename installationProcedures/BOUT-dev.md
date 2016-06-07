# Installation of BOUT-dev

...through own experience

- [Install MPI](#install-mpi)
- [Installation of optional external libraries](#installation-of-optional-external-libraries)
    - [Install Sundials](#install-sundials)
    - [Install PETSc](#install-petsc)
- [BOUT-dev installation](#bout-dev-installation)
    - [BOUT-dev installation on laptop](#bout-dev-installation-on-laptop)
    - [BOUT-dev installation on jess](#bout-dev-installation-on-jess)

**NOTE**:

1. This note is written for BOUT-dev 3.0.
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
./configure --prefix=$HOME/local CC=gcc CXX=g++ FC=gfortran
```


## Install Sundials

At the time of writing, sundials can be obtained by

```
cd ~
mkdir local
cd local
mkdir examples
cd ..
mkdir install
cd install
wget http://computation.llnl.gov/projects/sundials-suite-nonlinear-differential-algebraic-equation-solvers/download/sundials-2.6.2.tar.gz
tar -xzvf sundials-2.6.2.tar.gz
rm sundials-2.6.2.tar.gz
cd sundials-2.6.2
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
```

but be aware that the url will probably change as new versions will come.

## Install PETSc

Currently PETSc-3.5.4 is working nicely.

Before you start you may have to install `gfortran` (this is usually installed
on the clusters)

```
sudo apt-get install gfortran
```

continue with

```
cd ~
wget http://ftp.mcs.anl.gov/pub/petsc/release-snapshots/petsc-3.5.4.tar.gz
tar -xzvf petsc-3.5.4.tar.gz
rm petsc-3.5.4.tar.gz
cd petsc-3.5.4
```

switch to python 2 (what a shame...)

```
./configure \
--with-clanguage=cxx \
--with-mpi=1 \
--with-precision=double \
--with-scalar-type=real \
--with-shared-libraries=0 \
--download-fblaslapack=1
```

Check that everything works, if not, it could be that downloading with PETSc
can help. See BOUT's user manual for more info.

```
make PETSC_DIR=$HOME/petsc-3.5.4 PETSC_ARCH=arch-linux2-cxx-debug all
```

Testing

```
make PETSC_DIR=$HOME/petsc-3.5.4 PETSC_ARCH=arch-linux2-cxx-debug test
```

Add the following line to your `.bashrc`:

```
export PETSC_DIR=$HOME/petsc-3.5.4
```

Run the same command in your shell.

##  BOUT-dev installation on laptop

### Preparations
```
sudo apt-get install libfftw3-dev libnetcdf-dev
```
install netcdf4 through [conda](python.md)

**NOTE**: `netcdf4` version `1.2.2` can give

```
WARNING: netcdf4-python module not found
         expect poor performance
           => Using scipy.io.netcdf instead
```

`netcdf4` version `1.2.1` seem to work

Install [Sundials](#install-sundials)
Install [PETSc](#install-petsc)



### Configure BOUT-dev
cd into the BOUT-dev folder

```
./configure --with-checks=3 --with-track --with-debug --with-petsc --with-sundials
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

## BOUT-dev installation on jess

### Installation of `fftw`

Follow the instructions in the `user_manual`, and configure with

```
./configure --prefix=$HOME/local
```

### Installation of `netcdf-4.1.3`

Before the installation

```
conda install hdf5=1.8.9
./configure --prefix=$HOME/local CPPFLAGS="-I/$HOME/anaconda3/include" LDFLAGS="-I/$HOME/anaconda3/lib"
export LD_LIBRARY_PATH=$HOME/local/lib:$LD_LIBRARY_PATH
```

Put this in your `~/.bashrc`

```
export LD_LIBRARY_PATH=$HOME/local/lib:$LD_LIBRARY_PATH
source ~/.bashrc
```

follow the instructions given in the `user_manual`

### Configure BOUT-dev

cd into the BOUT-dev folder

```
./configure --with-checks=no --with-fftw --with-netcdf --with-petsc --with-sundials --with-optimize=3
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

`netcdf4` version `1.2.1` seem to work
