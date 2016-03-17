# Installation of python

**NOTE**: This also works on clusters, and places where one do not have root
access

## Install using anaconda
The easiest way to install python and packages are through anaconda
https://store.continuum.io/cshop/anaconda/
But please, download python 3. If python 2 is wanted, rather install it as a
[environment](make-a-python-2.7-environment).

The curious reader who wants to know a bit more about conda is recommended to
check http://conda.pydata.org/docs/intro.html

Install anaconda through the downloaded file
```
cd ~/Downloads
chmod +x Anaconda*
./Anaconda*
```
where `*` denotes the filename.

Add
```
eval "$(register-python-argcomplete conda)"
```
to the `.bashrc` file in order to get autocompletion

## Install the essentials
```
conda install argcomplete future mpich2 netcdf4
conda update --all
```
On clusters, you may want to `conda install imagemagick` through binstar

**NOTE**
* Sometimes `scipy` etc. is installed with `mkl`, this can cause trouble. To fix
  ```
  conda remove mkl
  conda update --all
  ```
* Some versions of netcdf4 (i.e. 1.2.2) appears broken
  If so, this is has been found to work
  ```
  conda install netcdf4=1.2.1
  ```

## Make a python 2.7 environment
Packages like `mayavi` only works with python 2.7 (per 2015.02.14) due to vtk.
Therefore a python 2 environment can be good to have
```
conda create -n py27 python=2.7 anaconda
conda install -n py27 mayavi wxpython future mpich2 netcdf4
conda update -n py27 --all
```
To switch environment, type
```
source activate py27
```
To switch back, type
```
source deactivate
```

## Install from binstart
**NOTE**: One can always install through `pip` in `conda`.
If you do not want to install through `pip`, the following example explains how
to use binstart

```
conda install bunch
```
Returns
```
...
Error ...
You can search for this package on Binstar with

   binstar search -t conda bunch
```

### Option 1
http://stackoverflow.com/questions/18640305/how-to-keep-track-of-pip-installed-packages-in-an-anaconda-conda-env
```
conda install patchelf
conda skeleton pypi bunch
conda build bunch
```
Returns
```
...
If you want to upload this package to binstar.org later, type:

$ binstar upload $HOME/anaconda3/conda-bld/linux-64/bunch-1.0.1-py34_0.tar.bz2
```
To install
```
conda install $HOME/anaconda3/conda-bld/linux-64/bunch-1.0.1-py34_0.tar.bz2
```

### Option 2 (works sometimes)
```
binstar search -t conda bunch
```
Returns
```
Run 'binstar show <USER/PACKAGE>' to get more details:
...
auto/bunch | published    | conda           | http://github.com/dsc/bunch
```
Type
```
binstar show auto/bunch
```
which returns
```
...
To install this package with conda run:
    conda install --channel https://conda.binstar.org/auto bunch
```
If you want to install it on another environment, type
```
conda install -n py27 --channel https://conda.binstar.org/auto bunch
conda install --channel https://conda.binstar.org/auto bunch
```
