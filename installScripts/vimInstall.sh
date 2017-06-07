#!/usr/bin/env bash
# https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source

INSTALL_PLUGINS="true"
INSTALL_XBUILD="true"
PYTHON_VERSION="3.6.1"

# Exit on error
set -e

echo -e "\n\n\nRemoving old vim ..."
sudo apt remove -y vim \
    vim-runtime \
    gvim \
    vim-tiny \
    vim-common \
    vim-gui-common
cd $HOME
rm -rf vim .vim
echo -e "Done"

echo -e "\n\n\nInstalling prerequisites ..."
sudo apt install -y libncurses5-dev \
    libgnome2-dev \
    libgnomeui-dev \
    libgtk2.0-dev \
    libatk1.0-dev \
    libbonoboui2-dev \
    libcairo2-dev \
    libx11-dev \
    libxpm-dev \
    libxt-dev \
    python-dev \
    ruby-dev \
    mercurial \
    cmake \
    g++
echo -e "Done"

# Install vim
echo -e "\n\n\nInstalling vim ..."
cd ~
git clone https://github.com/vim/vim.git
cd vim
./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp \
            --enable-pythoninterp \
            --with-python-config-dir=$HOME/anaconda3/envs/py27/lib/python2.7/config \
            --enable-python3interp \
            --with-python3-config-dir=$HOME/anaconda3/lib/python3.5/config-3.5m \
            --enable-perlinterp \
            --enable-luainterp \
            --enable-gui=gtk2 --enable-cscope --prefix=/usr
make VIMRUNTIMEDIR=/usr/share/vim/vim74
sudo make install
echo -e "Done"

echo -e "\n\n\nUpdating settings for editors ..."
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
sudo update-alternatives --set editor /usr/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1
sudo update-alternatives --set vi /usr/bin/vim
echo -e "Done"


if [ "$INSTALL_PLUGINS" = "true" ]; then

    echo -e "\n\n\nInstalling vundle..."
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall
    echo -e "Done"

    echo -e "\n\n\nInstalling You Complete Me..."
    cd ~/.vim/bundle/YouCompleteMe
    if [ "$INSTALL_XBUILD" = "true" ]; then
        sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
        echo "deb http://download.mono-project.com/repo/ubuntu xenial main" | sudo tee /etc/apt/sources.list.d/mono-official.list
        sudo apt-get update
        sudo apt-get install mono-devel
        ./install.py --clang-completer --omnisharp-completer
    else
        ./install.py --clang-completer
    fi
    echo -e "Done"

    echo -e "\n\n\nInstalling pyclewn..."
    pip install --user pyclewn
    # The "test" folder is needed for installation
    wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tar.xz
    tar -xvf Python-${PYTHON_VERSION}.tar.xz
    rm Python-${PYTHON_VERSION}.tar.xz
    scp -r Python-*/Lib/test $HOME/anaconda3/lib/python3*
    rm -rf Python-${PYTHON_VERSION}
    cd ~
    python -c "import clewn; clewn.get_vimball()"
    vim -c 'source %' -c 'q' pyclewn-2.3.vmb
    rm pyclewn-2.3.vmb
    echo -e "Done"

fi


echo -e "\n\n\nInstallation successfully completed"
