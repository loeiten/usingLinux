# Installation of python

**NOTE**: This also works where one do not have root access

1. [Install using anaconda](#install-using-anaconda)
2. [Install the essentials](#install-the-essentials)
3. [Make a python 2.7 environment](#make-a-python-2.7-environment)
4. [Contribute to package development](#contribute-to-package-development)
5. [Install from binstar](#install-from-binstar)

## Install using anaconda

See [condaInstall.sh](../installScripts/condaInstall.sh) for installation

**NOTE**
* Sometimes `scipy` etc. is installed with `mkl`, this can cause trouble. To fix

  ```
  conda remove mkl
  conda update --all
  ```

* Some versions of netcdf4 (i.e. `1.2.2`) appears broken
  If so, this is has been found to work

  ```
  conda install hdf4=4.2.12
  conda install netcdf4=1.2.1
  ```

## Make a python 2.7 environment

Some packages may not be compatible with `python3`. In such cases, one can
create environments

```
conda create -n py27 python=2.7 anaconda
conda install -n py27 package_not_compatible_with_python_3
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

## Contribute to package development

At the time of writing there is no easy way to download a package directly from
github using conda.

As a workaround one can make an environment with conda

```
conda create -n myDevelEnv anaconda
```

The package can be cloned from github in standard way, and installation of the
package can usually be done by

```
source activate myDevelEnv
python setup.py develop
```

Note that this will install into the current environment.

https://github.com/sympy/sympy/pull/10837

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
