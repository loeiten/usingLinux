# Install vim

This will get and build vim if you are super user.
* [Build vim](build-vim)
* [Install vundle](install-vundle)
* [Install NerdTree](install-nerdtree)
* [Install You Complete Me](install-ycm)
* [Install pyclewn](install-pyclewn)

## Build vim
Modified from: https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source

```
sudo apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev \
    libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
    libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
    ruby-dev mercurial

sudo apt-get remove vim vim-runtime gvim

sudo apt-get remove vim-tiny vim-common vim-gui-common
```
Then

```
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
```
There are two alternatives from here
a) `sudo make install`
b) `sudo apt-get install checkinstall &&  sudo checkinstall`
   this works, but has given troubles with package manager

Then
```
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
sudo update-alternatives --set editor /usr/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1
sudo update-alternatives --set vi /usr/bin/vim
```

## Install vundle
Follow the instructions on https://github.com/gmarik/Vundle.vim

## Install NerdTree
If the `vimrc` file is properly set up (see [install vundle](#install-vundle),
then this should be possible to download with `:PluginInstall`

## Install YCM
1. Get it from vundle
2. Follow step on https://github.com/Valloric/YouCompleteMe#ubuntu-linux-x64
   If this doesn't work, see below
3. Add
   `let g:ycm_global_ycm_extra_conf = '<home-path>/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'`
   to your `.vimrc`
4. Check that you spelled the home folder correct form step 3
   (unfortunately looks like `$HOME/` doesn't work)

### If step 2 fails
If this doesn't work, check the full installation manual
https://github.com/Valloric/YouCompleteMe#full-installation-guide
- Get LLVM lib:
  http://llvm.org/releases/download.html#3.3
  Clang Binaries for 64-bit Ubuntu-13.04
  Extract it to `~/ycm_tmp/llvm_root_dir`
- **NOTE** :

  ```
  cmake -G "Unix Makefiles" -DPATH_TO_LLVM_ROOT=~/ycm_tmp/llvm_root_dir . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
  ```
  Rather than

  ```
  cmake -G "Unix Makefiles" -DPATH_TO_LLVM_ROOT=~/ycm_temp/llvm_root_dir . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
  ```

## Install pyclewn
See [pyclewn.md](pyclewn.md)
