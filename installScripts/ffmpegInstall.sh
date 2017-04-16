#!/usr/bin/env bash

# Installs ffmpeg
FFMPEG_VERSION="3.1.4"
YASM_VERSION="1.3.0"

# exit on error
set -e

# Install ffmpeg
echo -e "\n\n\nInstalling ffmpeg\n\n\n"
echo -e "\n\n\nNow building yasm\n\n\n"
cd $HOME
mkdir -p local
cd local
mkdir -p examples
cd ..
mkdir -p install
cd install
wget http://www.tortall.net/projects/yasm/releases/yasm-${YASM_VERSION}.tar.gz
tar -xvzf yasm-${YASM_VERSION}.tar.gz
cd yasm-${YASM_VERSION}
# : is the no-op command
make clean || :
./configure --prefix=$HOME/local
make
make check
make install

echo -e "\n\n\nNow building x264\n\n\n"
cd ..
git clone git://git.videolan.org/x264.git
cd x264/
./configure --prefix=$HOME/local --enable-static --enable-shared
make
make install

echo -e "\n\n\nNow building ffmpeg\n\n\n"
cd ..
wget http://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.bz2
tar -xvf ffmpeg-${FFMPEG_VERSION}.tar.bz2
cd ffmpeg-${FFMPEG_VERSION}
# : is the no-op command
make clean || :
./configure --prefix=$HOME/local --enable-gpl --enable-libx264 \
            --extra-ldflags=-L$HOME/local/lib \
            --extra-cflags=-I$HOME/local/include
make
make install
echo -e "\n\n\nDone installing ffmpeg\n\n\n"
