#!/bin/bash

# Installs cmake
CMAKE_MAJOR="3"
CMAKE_MINOR="7"
CMAKE_PATCH="2"

# exit on error
set -e

CMAKE_MAJOR_MINOR=${CMAKE_MAJOR}.${CMAKE_MINOR}
CMAKE_VERSION=${CMAKE_MAJOR_MINOR}.${CMAKE_PATCH}

echo -e "\nDownloading CMAKE\n"
cd $HOME
mkdir -p local
mkdir -p install
cd install
wget --no-check-certificate http://cmake.org/files/v${CMAKE_MAJOR_MINOR}/cmake-${CMAKE_VERSION}.tar.gz
tar -xzvf cmake-${CMAKE_VERSION}.tar.gz
cd cmake-${CMAKE_VERSION}
echo -e "\nConfiguring\n"
./bootstrap --prefix=$HOME/local
echo -e "\nMaking\n"
make
make install
echo -e "\n\n\nSuccess!"
