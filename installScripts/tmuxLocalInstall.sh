#!/bin/bash

# This based on https://gist.github.com/brandondrew/3915551, which is a fork of
# https://gist.github.com/ryin/3106801

TMUX_VERSION="2.3"
LIBEVENT_VERSION="2.1.8"
NCURSES_VERSION="6.0"

# Script for installing tmux on systems where you don't have root access.
# tmux will be installed in $HOME/local/bin.
# It's assumed that wget and a C/C++ compiler are installed.

# exit on error
set -e

# create our directories
mkdir -p $HOME/local $HOME/tmux_tmp
cd $HOME/tmux_tmp

# download source files for tmux, libevent, and ncurses
echo -e "\n\n\n\n\nDownloading tmux...\n\n"
wget -O tmux-${TMUX_VERSION}.tar.gz https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz
echo -e "\n\n\n\n\n Downloading libevent...\n\n"
wget -O libevent-${LIBEVENT_VERSION}-stable.tar.gz https://github.com/libevent/libevent/releases/download/release-${LIBEVENT_VERSION}-stable/libevent-${LIBEVENT_VERSION}-stable.tar.gz
echo -e "\n\n\n\n\n Downloading ncurses...\n\n"
wget -O ncurses-${NCURSES_VERSION}.tar.gz http://ftp.gnu.org/gnu/ncurses/ncurses-${NCURSES_VERSION}.tar.gz

# extract files, configure, and compile

############
# libevent #
############
echo -e "Installing libevent..."
tar xvzf libevent-${LIBEVENT_VERSION}-stable.tar.gz
cd libevent-${LIBEVENT_VERSION}-stable
./configure --prefix=$HOME/local --disable-shared
make
make install
cd ..

############
# ncurses  #
############
# http://stackoverflow.com/questions/37475222/ncurses-6-0-compilation-error-error-expected-before-int
export CPPFLAGS="-P"
echo -e "Installing ncurses..."
tar xvzf ncurses-${NCURSES_VERSION}.tar.gz
cd ncurses-${NCURSES_VERSION}
./configure --prefix=$HOME/local
make
make install

############
# tmux     #
############
echo -e "Installing tmux..."
tar xvzf tmux-${TMUX_VERSION}.tar.gz
cd tmux-${TMUX_VERSION}
./configure CFLAGS="-I$HOME/local/include -I$HOME/local/include/ncurses" LDFLAGS="-L$HOME/local/lib -L$HOME/local/include/ncurses -L$HOME/local/include"
CPPFLAGS="-I$HOME/local/include -I$HOME/local/include/ncurses" LDFLAGS="-static -L$HOME/local/include -L$HOME/local/include/ncurses -L$HOME/local/lib" make
cp tmux $HOME/local/bin
cd ..

# cleanup
echo -e "Clean-up..."
rm -rf $HOME/tmux_tmp

echo "$HOME/local/bin/tmux is now available. You can optionally add $HOME/local/bin to your PATH."
