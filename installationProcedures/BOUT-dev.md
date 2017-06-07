# Installation of BOUT-dev

**NOTE**: An installation script can be found [here](../installScripts/boutPPInstall.sh).
This note just discusses commonly encountered issues.

Before you start:

1. **Make sure that your anaconda installation is not interferring with BOUT++
   installation**. This is the most common source of errors, and the error
   messages displayed are usually symptoms and not the causes for those
   symptoms.
2. Another main cause for a failed installation, is that libraries are not
   found. Make sure that [all](../installScripts/boutPPInstall.sh#L155) are available in the `~/.bashrc`-file.
3. It is highly recommended to clone from the [BOUT-dev](https://github.com/boutproject/BOUT-dev) repository.


## Problems with MPI

1. There are more binaries of mpi installed: This causes every processor to
   have processor ID = 0 (can be seen from the `BOUT.*.log` files.

## Problems with PETSc

Currently `PETSc-3.4.5` is working nicely.

1. Every now and then, `gfortran` is not installed. This can be installed
   through installing `GCC`, or by installing through the package manager using
   `sudo apt-get install gfortran`

## Problems with NetCDF

Anaconda `netcdf4` version `1.2.2` can give

```
WARNING: netcdf4-python module not found
         expect poor performance
           => Using scipy.io.netcdf instead
```

`netcdf4` version `1.2.1` seem to work  (install with `conda install netcdf4=1.2.1`)

There may be package conflicts because a misconfiguration with `hdf`. In that
case, make sure `hdf-4.2.12` is installed.

## Other problems

If

```
python path/to/BOUT/examples/bout_runners/6a-run_with_MMS_post_processing_specify_numbers.py
```

yeilds

```
./3D_diffusion: $HOME/anaconda3/lib/libgfortran.so.3: version 'GFORTRAN_1.4' not found (required by ./3D_diffusion)
```

There is probably a problem with `PETSc`.
A workaround is to bypass the anaconda libfortran (which comes from the `scipy`
package). Putting this to the `.bashrc` file helps

```
export LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libgfortran.so.3
```

**NOTE**: One need to address the correct path here. Other suggestion include
downloading the scipy library to 0.16.0
https://github.com/ContinuumIO/anaconda-issues/issues/686

## Alternative laptop installations

If a non-local installation is preferred, the required packages can be
installed as indicated in the
[manual](http://bout-dev.readthedocs.io/en/latest/user_docs/getting_started.html).
