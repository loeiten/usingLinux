Install using anaconda
======================
The easiest way to install python and packages are through anaconda
https://store.continuum.io/cshop/anaconda/
Install the 3.* (you can have 2.* as an environment)

To download, you might need to register your email account, but I have never
seen that the email have been used

Once downloaded, see how to use it on
http://conda.pydata.org/docs/intro.html



Once updated
=============
conda install argcomplete future mpich2 netcdf4
conda update --all
# !!!!!!!!!! WARNING: SOME OF THE ANIMATION PROCEDURES DID NOT WORK PROPERLY IN matplotlib 1.5.0
# On clusters:
# conda install imagemagick
# And install through binstar

Then add
eval "$(register-python-argcomplete conda)"
to bashrc


NOTE:
=====
Sometimes scipy etc. is installed with mkl, this can cause trouble. To fix
conda remove mkl
conda update --all

Some versions of netcdf4 (i.e. 1.2.2) appears broken
If so, this is has been found to work
# conda install netcdf4=1.2.1


Make a python 2.7 environment
=============================
conda create -n py27 python=2.7 anaconda
# Mayavi only works with python 2.7 (per 2015.02.14) due to vtk
#For mayavi install wxpython
# We need future to use the builtins from futurize
conda install -n py27 mayavi wxpython future mpich2 netcdf4
conda update -n py27 --all



To switch
=========
source activate py27
#To switch back
source deactivate



Install from binstart
=======================
!!!NOTE!!!
Can always install from pip

conda install bunch
# Returns
# (...)
# Error (..)
# You can search for this package on Binstar with
#
#    binstar search -t conda bunch

OPTION 1.
---------
conda install patchelf
#http://stackoverflow.com/questions/18640305/how-to-keep-track-of-pip-installed-packages-in-an-anaconda-conda-env
# Which states
conda skeleton pypi bunch
conda build bunch
# Returns
# (...)
# If you want to upload this package to binstar.org later, type:
#
# $ binstar upload $HOME/anaconda3/conda-bld/linux-64/bunch-1.0.1-py34_0.tar.bz2

# We now need to actually install the stuff
conda install $HOME/anaconda3/conda-bld/linux-64/bunch-1.0.1-py34_0.tar.bz2


OPTION 2. (works sometimes)
---------------------------
binstar search -t conda bunch
# Returns (amongst others)
# Run 'binstar show <USER/PACKAGE>' to get more details:
# (...)
# auto/bunch | published    | conda           | http://github.com/dsc/bunch


binstar show auto/bunch
# (...)
# To install this package with conda run:
#     conda install --channel https://conda.binstar.org/auto bunch


# NOTE: If you want to install it on another environment, type
# conda install -n py27 --channel https://conda.binstar.org/auto bunch
conda install --channel https://conda.binstar.org/auto bunch

















OLD STUFF (maybe even deprecated)
=================================
TOC
Nice overview
Before startup
Setup tcl and tk for tkinter
Install python
Install pip
Install BLAS and LAPACK
Install debugging tools
Get the newest version of sympy, matplotlib and mayavi when you are root


    Nice overview
===============================================================================
http://scipy.org/
Course guide
http://gunheeleo.blogspot.dk/2010/04/python-install-numpy-and-scipy-without.html
! NOTE: NO SUCH THING AS libflapack.a: If need BLAS and LAPACK
http://stackoverflow.com/questions/7496547/python-scipy-needs-blas
Now, need to setup tkinter
http://stackoverflow.com/questions/4783810/install-tkinter-for-python
Usign pip
http://pip.readthedocs.org/en/latest/installing.html
===============================================================================



    Before startup
===============================================================================
    Put all the tar files here so it is easy to clean up after installation
mkdir install
    Your download folder
mkdir Downloads

    To unzip a tar file
tar -xzvf <name>
===============================================================================



    Setup tcl and tk for tkinter
===============================================================================
Dowload from
http://www.tcl.tk/software/tcltk/download.html

mv ~/Downloads/* ~/install

    Put your stuff in src so that python can find it for you
mkdir src

cd ~/install

    Unzip tcl
    Unzip tk

cd ~/install/tcl*/unix
./configure --prefix=/home/mmag/src --exec-prefix=/home/mmag/src
make
make install
cd ~/install/tk*/unix
./configure --prefix=/home/mmag/src --exec-prefix=/home/mmag/src --with-tcl=/home/mmag/install/tcl<version>/unix
make
make install


    Add the following to .bashrc to specify where tcl and tk can be found
# Tcl and tk
export CPPFLAGS=-I$HOME/src/include
export LDFLAGS=-L$HOME/src/lib
export LD_LIBRARY_PATH=$HOME/src/lib

    Since you may be on a ssh, and don't want to log out in order to make the
    changes in bashrc to work, you can also write this to the terminal
export CPPFLAGS=-I$HOME/src/include
export LDFLAGS=-L$HOME/src/lib
export LD_LIBRARY_PATH=$HOME/src/lib
===============================================================================



    Install python
===============================================================================
Download from 
http://www.python.org/download/

mv ~/Downloads/* ~/install
mkdir ~/lib
mkdir ~/python-<version>/
cd ~/install

    Unzip python

cd Python-<version>
make clean
./configure --prefix=/home/mmag/lib/python-<version>/
make
make install

    Add the following to .bashrc to specify where python can be found
# Add PATH for local python
PATH=$HOME/lib/python-<version>/bin:$PATH
# Set where to find python (for numpy etc)
export PYTHONPATH=$HOME/lib/python-<version>/lib/python:$PYTHONPATH

    Also write it into the terminal
PATH=$HOME/lib/python-<version>/bin:$PATH
export PYTHONPATH=$HOME/lib/python-<version>/lib/python:$PYTHONPATH


    ! NOTE, NOW THAT PYTHON HAS BEEN BUILD, WE DON'T NEED THE FLAGS IN .bashrc
    ANYMORE
    THEREFORE REMOVE THEM AND RESTART TERMINAL
    (however, keep the LD_LIBRARY_PATH)
===============================================================================


    Install pip 
    (if this doesn't work, you can download and untar the .tar.gz files, then run 
     python setup.py install --home=~/lib/python-<version>/
    )
===============================================================================
Download from
http://pip.readthedocs.org/en/latest/installing.html

mv ~/Downloads/* ~/install
cd ~/install
python get-pip.py

pip install --user numpy
# Test (there must be no error)
python -c "import numpy; print numpy.__file__"


pip install --user scipy
    If you get a warning that BLAS and LAPACK is not installed, install first
    (see below)
    If it fails due to some ASCII stuff see alternative installation of scipy

**********Alternative installation of scipy**********
    Download from
http://sourceforge.net/projects/scipy/files/

tar -xzvf scipy-<version>.tar.gz
cd scipy-<version>
python setup.py install --home=~/lib/python-<version>/
******************************************************
    Exit the terminal and open it again

# Test (there must be no error)
python -c "import scipy; print scipy.__file__"

pip install --user sympy
# Test (there must be no error)
python -c "import sympy; print sympy.__file__"

pip install --user matplotlib
# NOTE: IF HAVING TROUBLE WITH NEVER VERSIONS, TRY
#pip install --user https://pypi.python.org/packages/source/m/matplotlib/matplotlib-1.3.1.tar.gz
# Test (there must be no error)
python -c "import matplotlib; print matplotlib.__file__"

pip install --user ipython
export PATH=$HOME/.local/bin:$PATH

    Edit vimrc
# For ipython
export PATH=$HOME/.local/bin:$PATH

ipython --pylab

    Note what backend pylab is running with. It should be:
    Using matplotlib backend: TkAgg
    If
    Using matplotlib backend: agg
    it means that the installation of matplotlib did not find the tk installed
    previosly. If so, log out of the system, run
pip uninstall matplotlib
pip install --user matplotlib

    To check if everything works, run
ipython --pylab
plt.plot([0,1],[1,0])
===============================================================================



    Install BLAS and LAPACK
    (if scipy failed to install from pip, if not you can skip to next)
===============================================================================
#BLAS !NOTE THAT WE ARE NOT INSTALLING IN INSTALL, BUT RATHER SRC
cd ~/src
wget http://www.netlib.org/blas/blas.tgz
tar -xzvf blas.tgz
cd BLAS

## NOTE: The selected fortran compiler must be consistent for BLAS, LAPACK, NumPy, and SciPy.
## For GNU compiler on 32-bit systems:
#g77 -O2 -fno-second-underscore -c *.f                     # with g77
#gfortran -O2 -std=legacy -fno-second-underscore -c *.f    # with gfortran
## OR for GNU compiler on 64-bit systems:
#g77 -O3 -m64 -fno-second-underscore -fPIC -c *.f                     # with g77
gfortran -O3 -std=legacy -m64 -fno-second-underscore -fPIC -c *.f    # with gfortran
## OR for Intel compiler:
#ifort -FI -w90 -w95 -cm -O3 -unroll -c *.f

# Continue below irrespective of compiler:
ar r libfblas.a *.o
ranlib libfblas.a
rm -rf *.o
export BLAS=~/src/BLAS/libfblas.a




# LAPACK !NOTE THAT WE ARE NOT INSTALLING IN INSTALL, BUT RATHER SCR
cd ~/src
wget http://www.netlib.org/lapack/lapack.tgz
tar -xzvf lapack.tgz
cd lapack-*/
cp INSTALL/make.inc.gfortran make.inc          # on Linux with lapack-3.2.1 or newer

    Edit make.inc
OPTS = -O2 -fPIC
NOOPT = -O0 -fPIC


make lapacklib
make clean
export LAPACK=~/src/lapack-*/liblapack.a


    Edit bashrc
# BLAS and LAPACK
export BLAS=$HOME/path/to/libfblas.a
export LAPACK=$HOME/src/lapack-/liblapack.a

cd ..
rm *.tgz
===============================================================================



    Install debugging tools
===============================================================================
    objgraph (to list memory usage and graph objects)
pip install --user objgraph

    pympler (to check the size of an object)
pip install --user pympler
===============================================================================




    Get the newest version of sympy, matplotlib and mayavi when you are root
===============================================================================
    sympy
Use 
python setup.py install
http://docs.sympy.org/dev/install.html

    matplotlib
Use 
python setup.py install
Download
http://matplotlib.org/downloads.html
You might also need 
sudo apt-get install gcc
sudo apt-get install python-dateutil python-docutils python-feedparser python-gdata python-jinja2 python-ldap python-libxslt1 python-lxml python-mako python-mock python-openid python-psycopg2 python-psutil python-pybabel python-pychart python-pydot python-pyparsing python-reportlab python-simplejson python-tz python-unittest2 python-vatnumber python-vobject python-webdav python-werkzeug python-xlwt python-yaml python-zsi
sudo apt-get install build-essential autoconf libtool pkg-config python-opengl python-imaging python-pyrex python-pyside.qtopengl idle-python2.7 qt4-dev-tools qt4-designer libqtgui4 libqtcore4 libqt4-xml libqt4-test libqt4-script libqt4-network libqt4-dbus python-qt4 python-qt4-gl libgle3 python-dev
sudo easy_install green let
sudo easy_install gevent
(http://stackoverflow.com/questions/26053982/error-setup-script-exited-with-error-command-x86-64-linux-gnu-gcc-failed-wit)
Use
python setup.py install

    mayavi
http://docs.enthought.com/mayavi/mayavi/index.html
(Need to install the mayavi 2 package from the distribution?)
Use 
python setup.py install
https://pypi.python.org/pypi/mayavi
ipython --gui=wx
===============================================================================
