#!/usr/bin/env bash

# NOTE: A standalone build script exists
# https://github.com/tesseract-ocr/tesseract/wiki/Compiling#miscellaneous
# https://pastebin.com/VnGLHfbr

# See https://github.com/tesseract-ocr/tesseract/wiki/Compiling#install-elsewhere--without-root

# NOTE:
# There must be a correspondence bewteen leptonica and tesseract
# https://github.com/tesseract-ocr/tesseract/wiki/Compiling#leptonica

LEPT_VER="1.74.0"
TESS_VER="3.05.00"
# NOTE: There must be correspondence to the training url and the tesseract version
TRAIN_VER="3.04.00"

# Languages
# NOTE: OSD is orientation and script detection
declare -a LANGS=("osd" "nor" "eng")

cd $HOME
mkdir -p local
mkdir -p install
cd install

# exit on error
set -e

# Install Leptonica
echo -e "\nDownloading Leptonica\n"
wget -O leptonica_${LEPT_VER}.tar.gz https://github.com/DanBloomberg/leptonica/archive/${LEPT_VER}.tar.gz
tar -xzvf leptonica_${LEPT_VER}.tar.gz
cd leptonica-${LEPT_VER}

echo -e "\nInstalling Leptonica\n"
./autobuild
./configure  --prefix=$HOME/local/
make
make install
echo -e "\nDone\n"

echo -e "\n\n\n\n\n"
cd $HOME/install
echo -e "\nDownloading tesseract\n"
wget -O tesseract_${TESS_VER}.tar.gz https://github.com/tesseract-ocr/tesseract/archive/${TESS_VER}.tar.gz
tar -xzvf tesseract_${TESS_VER}.tar.gz
cd tesseract-${TESS_VER}

echo -e "\nInstalling tesseract\n"
./autogen.sh
LIBLEPT_HEADERSDIR=$HOME/local/include ./configure --prefix=$HOME/local/ --with-extra-libraries=$HOME/local/lib
make
make install
echo -e "\nDone\n"

echo -e "\nInstalling languages\n"
cd $HOME/install
for LANG in "${LANGS[@]}"
do
   echo -e "\nInstalling ${LANG}\n"
   wget https://github.com/tesseract-ocr/tessdata/raw/${TRAIN_VER}/${LANG}.traineddata
   mv ${LANG}.traineddata ${HOME}/local/share/tessdata/
   echo -e "\nDone\n"
done
echo -e "\nDone\n"

echo -e "\n\n\nSuccess!"
