#!/usr/bin/env bash

# Installs the master branch of BOUT-dev


# Options
# ==============================================================================
VERBOSE="true"           # Only set to "false" in order for travis to work
INSTALL_CONDA="true"     # Needed for post-processing
INSTALL_CMAKE="false"    # Needed for sundials if CMAKE is below 2.8.11
INSTALL_FFMPEG="true"    # Needed for post-processing if x264 is not present
INCL_SUNDIALS="true"     # The preferred time solver
INCL_PETSC_SLEPC="false" # Only needed for fancy features
OPTIMIZING="true"        # Good for speed
DEBUG="false"            # Good for debugging, bad for speed
# ==============================================================================


# Preparations
# ==============================================================================
# exit on error
set -e

# Get the path of the calling script
# http://stackoverflow.com/questions/59895/getting-the-source-directory-of-a-bash-script-from-within
CURDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Ensure paths are available when building
export PATH="$HOME/local/bin:$PATH"
export LD_LIBRARY_PATH=$HOME/local/lib:$LD_LIBRARY_PATH
export PYTHONPATH="$HOME/BOUT-dev/tools/pylib/:$PYTHONPATH"

# Extra packages and flags for BOUT-dev
EXTRA_PACKAGES=""
EXTRA_FLAGS=""

# Set appropriate flags
if [ "$OPTIMIZING" = "true" ]; then
    EXTRA_FLAGS="${EXTRA_FLAGS} --enable-checks=no --enable-optimize=3"
elif [ "$DEBUG" = "true" ]; then
    EXTRA_FLAGS="${EXTRA_FLAGS} --enable-debug --enable-checks=3 --enable-track"
fi

# Travis 4MB workaround
# http://stackoverflow.com/questions/26082444/how-to-work-around-travis-cis-4mb-output-limit/26082445#26082445
# ..............................................................................
export PING_SLEEP=30s
export CURDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export BUILD_OUTPUT=$CURDIR/build.out

touch $BUILD_OUTPUT

dump_output() {
   echo Tailing the last 500 lines of output:
   tail -500 $BUILD_OUTPUT 1>&3 2>&4
}
error_handler() {
  echo ERROR: An error was encountered with the build.
  dump_output
  kill $PING_LOOP_PID
  exit 1
}

# If an error occurs, run our error handler to output a tail of the build
trap 'error_handler' ERR

# Set up a repeating loop to send some output to Travis.
bash -c "while true; do echo \$(date) - building ...; sleep $PING_SLEEP; done" &
PING_LOOP_PID=$!
# ..............................................................................

# Get stream 3 and 4 from stdout and stderr
exec 3>&1
exec 4>&2
# Set the verbosity
if [ ! "$VERBOSE" = "true" ]; then
    echo -e "\n\nRedirecting outputs to $BUILD_OUTPUT\n\n"
    # Redirect stdout and stderr
    exec 1>>$BUILD_OUTPUT
    exec 2>>$BUILD_OUTPUT
fi
# ==============================================================================


# Install packages needed for BOUT-dev
# ==============================================================================
if [ "$INSTALL_CONDA" = "true" ]; then
    echo ". $CURDIR/condaInstall.sh" 1>&3 2>&4
    . $CURDIR/condaInstall.sh
fi

if [ "$INSTALL_CMAKE" = "true" ]; then
    echo ". $CURDIR/cmakeInstall.sh" 1>&3 2>&4
    . $CURDIR/cmakeInstall.sh
fi

if [ "$INSTALL_FFMPEG" = "true" ]; then
    echo ". $CURDIR/ffmpegInstall.sh" 1>&3 2>&4
    . $CURDIR/ffmpegInstall.sh
fi

# Install mpi
echo ". $CURDIR/mpiInstall.sh" 1>&3 2>&4
. $CURDIR/mpiInstall.sh

# Install fftw
echo ". $CURDIR/fftwInstall.sh" 1>&3 2>&4
. $CURDIR/fftwInstall.sh

# Install hdf5
echo ". $CURDIR/hdf5Install.sh" 1>&3 2>&4
. $CURDIR/hdf5Install.sh

# Install netcdf
echo ". $CURDIR/netcdfInstall.sh" 1>&3 2>&4
. $CURDIR/netcdfInstall.sh

if [ "$INCL_SUNDIALS" = "true" ]; then
    # Install sudials
    echo ". $CURDIR/sundialsInstall.sh" 1>&3 2>&4
    . $CURDIR/sundialsInstall.sh
    EXTRA_PACKAGES="${EXTRA_PACKAGES} --with-sundials"
fi

if [ "$INCL_PETSC_SLEPC" = true ]; then
    # Install PETSc
    echo ". $CURDIR/PETScInstall.sh" 1>&3 2>&4
    . $CURDIR/PETScInstall.sh

    # Install SLEPc
    echo ". $CURDIR/SLEPcInstall.sh" 1>&3 2>&4
    . $CURDIR/SLEPcInstall.sh
    EXTRA_PACKAGES="${EXTRA_PACKAGES} --with-petsc --with-slepc"
fi
# ==============================================================================


# Builiding BOUT-dev master
# ==============================================================================
echo -e "\n\n\nInstalling BOUT-dev\n\n\n" 1>&3 2>&4
cd $HOME
git clone https://github.com/boutproject/BOUT-dev.git
cd BOUT-dev
# NOTE: Explicilty state netcdf and hdf5 in order not to mix with anaconda
./configure ${EXTRA_FLAGS} ${EXTRA_PACKAGES} --with-netcdf=$HOME/local --with-hdf5=$HOME/local
make
echo -e "\n\n\nDone installing BOUT-dev\n\n\n" 1>&3 2>&4
echo -e "\n\n\nChecking installation\n\n\n" 1>&3 2>&4
cd examples/bout_runners_example
make
python 6a-run_with_MMS_post_processing_specify_numbers.py
# ==============================================================================


# Write what needs to be exported
# ==============================================================================
echo -e "\n\n\nInstallation complete.\n" 1>&3 2>&4
echo -e "Make sure the following lines are present in your .bashrc:" 1>&3 2>&4
echo -e "export PYTHONPATH=\"\$HOME/BOUT-dev/tools/pylib/:\$PYTHONPATH\"" 1>&3 2>&4
echo -e "export PATH=\"\$HOME/local/bin:\$PATH\"" 1>&3 2>&4
echo -e "export LD_LIBRARY_PATH=\"\$HOME/local/lib:\$LD_LIBRARY_PATH\"" 1>&3 2>&4

if [ "$INCL_PETSC_SLEPC" = true ]; then
    echo -e "export PETSC_DIR=\"\$HOME/petsc-\${PETSC_VERSION}\"" 1>&3 2>&4
    echo -e "export PETSC_ARCH=\"arch-linux2-cxx-debug\""
    echo -e "export SLEPC_DIR=\"\$HOME/slepc-\${SLEPC_VERSION}\"" 1>&3 2>&4
fi

if [ "$INSTALL_CONDA" = true ]; then
    echo -e "export PATH=\"\$HOME/anaconda3/bin:\$PATH\"" 1>&3 2>&4
fi
# ==============================================================================


# Termination of travis workaround
# ==============================================================================
# Nicely terminate the ping output loop
kill $PING_LOOP_PID
# ==============================================================================
