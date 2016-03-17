This will get and build vim if you are super user
=================================================
Source: https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source
sudo apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev \
    libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
    libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
    ruby-dev mercurial

sudo apt-get remove vim vim-runtime gvim

sudo apt-get remove vim-tiny vim-common vim-gui-common

cd ~
git clone https://github.com/vim/vim.git
cd vim
./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp \
            --enable-pythoninterp \
            --with-python-config-dir=$HOME/anaconda3/lib/python3.5/config-3.5m \
            --enable-perlinterp \
            --enable-luainterp \
            --enable-gui=gtk2 --enable-cscope --prefix=/usr
make VIMRUNTIMEDIR=/usr/share/vim/vim74

# For easy uninstallation of package (have had problems that get troubles with update manager)
# sudo apt-get install checkinstall
# sudo checkinstall
sudo make install

sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
sudo update-alternatives --set editor /usr/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1
sudo update-alternatives --set vi /usr/bin/vim

# You may want to remove vim from the update manager



Install pyclewn
===============
See install_pyclewn.txt

Install and build vim
=====================
See the tutorial on YCM
NOTE: When Package Manager asks to update: Ignore any updates from vim


Install vundle
==============
https://github.com/gmarik/Vundle.vim


Install NerdTree
================
Install NerdTree (should be possible to see when typing :PluginInstall as it is
already written in the vimrc file)


Install YCM (also found in vimrc)
=================================
1. Get it from vundle (is already in my vimrc)
2. This has worked before
   https://github.com/Valloric/YouCompleteMe#ubuntu-linux-x64
   If step 2 doesn't work, see below
3. Add 
   let g:ycm_global_ycm_extra_conf = '/home/mmag/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
   to your .vimrc, and check that the home folder is correct (unfortunately looks like $HOME/ doesn't work)

If step 2 fails
   If this doesn't work, check the full installation (maybe there are some packages to get from there)
   The procedure described below has worked and worked partially
   https://github.com/Valloric/YouCompleteMe#full-installation-guide
   - Get LLVM lib:
     http://llvm.org/releases/download.html#3.3
     Clang Binaries for 64-bit Ubuntu-13.04 
     Extract it to ~/ycm_tmp/llvm_root_dir
   - STEP 4
     cmake -G "Unix Makefiles" -DPATH_TO_LLVM_ROOT=~/ycm_tmp/llvm_root_dir . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
     RATHER THAN
     cmake -G "Unix Makefiles" -DPATH_TO_LLVM_ROOT=~/ycm_temp/llvm_root_dir . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
