# Installation of BOUT-dev
...through own experience

- [MPI](#mpi)
- [On laptop](#on-laptop)
- [On jess](#on-jess)

## MPI
Do not install mpi in the way described in the manual, as this can give rise to
several mpi binaries (this will result in all processors giving processor nr 0.
Instead install through [conda](python.md)
```
conda install mpich2
```
Alternative, download mpich-3.1.4 and
```
./configure --prefix=$HOME/local CC=gcc CXX=g++ FC=gfortran
```

## On laptop
### Preparations
```
sudo apt-get install libfftw3-dev libnetcdf-dev
```
install netcdf4 through [conda](python.md)

**NOTE**: Version 1.2.2 can give problems, but version 1.2.1 seem to work

### Install PETSc
This shows how to install PETSc with sundials with letting PETSc install
sundials.
Currently PETSc-3.4.5 is working nicely.
```
sudo apt-get install gfortran
```
```
cd ~
wget http://ftp.mcs.anl.gov/pub/petsc/release-snapshots/petsc-3.4.5.tar.gz
tar -xzvf petsc-3.4.5.tar.gz
rm petsc-3.4.5.tar.gz
cd petsc-3.4.5
```
switch to python 2 (what a shame...)
```
./configure \
--with-clanguage=cxx \
--with-mpi=1 \
--with-precision=double \
--with-scalar-type=real \
--with-shared-libraries=0 \
--with-sundials \
--download-sundials \
--download-f-blas-lapack=1
```
Check that everything works, if not, it could be that downloading with PETSc
can help. See BOUT's user manual for more info.
```
make PETSC_DIR=$HOME/petsc-3.4.5 PETSC_ARCH=arch-linux2-cxx-debug all
```
Testing
```
make PETSC_DIR=$HOME/petsc-3.4.5 PETSC_ARCH=arch-linux2-cxx-debug test
```

### Configure BOUT-dev
cd into the BOUT-dev folder
```
./configure --with-checks=3 --with-track --with-debug --with-petsc=$HOME/petsc-3.4.5 --with-sundials
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

## On jess
Installation of fftw
```
./configure --prefix=$HOME/local
```
Installation of netcdf-4.1.3
```
conda install hdf5=1.8.9
./configure --prefix=$HOME/local CPPFLAGS="-I/$HOME/anaconda3/include" LDFLAGS="-I/$HOME/anaconda3/lib"
export LD_LIBRARY_PATH=$HOME/local/lib:$LD_LIBRARY_PATH
```
Put this in your ~/.bashrc
```
export LD_LIBRARY_PATH=$HOME/local/lib:$LD_LIBRARY_PATH
source ~/.bashrc
```

### Install PETSc
**NOTE**: This section is currently untested due to 'GFORTRAN_1.4' issues with
anaconda

This shows how to install PETSc with sundials with letting PETSc install
sundials.
Currently PETSc-3.4.5 is working nicely.
```
cd ~
wget http://ftp.mcs.anl.gov/pub/petsc/release-snapshots/petsc-3.4.5.tar.gz
tar -xzvf petsc-3.4.5.tar.gz
rm petsc-3.4.5.tar.gz
cd petsc-3.4.5
```
switch to python 2 (what a shame...)
```
./configure \
--with-clanguage=cxx \
--with-mpi=1 \
--with-precision=double \
--with-scalar-type=real \
--with-shared-libraries=0 \
--with-sundials \
--download-sundials \
```
Check that everything works, if not, it could be that downloading with PETSc
can help. See BOUT's user manual for more info.
```
make PETSC_DIR=$HOME/petsc-3.4.5 PETSC_ARCH=arch-linux2-cxx-debug all
```
Testing
```
make PETSC_DIR=$HOME/petsc-3.4.5 PETSC_ARCH=arch-linux2-cxx-debug test
```

### Configure BOUT-dev
cd into the BOUT-dev folder
```
./configure --with-checks=no --with-fftw=$HOME/local --with-netcdf=$HOME/local --with-petsc=$HOME/petsc-3.4.5 --with-sundials
make
cd examples/bout_runners_example
python 9-PBS_with_MMS_post_processing_grid_file.py
```
