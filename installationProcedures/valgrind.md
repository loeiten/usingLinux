    If valgirnds gives following output

the SIGRT32 signal is used internally by Valgrind
cr_libinit.c:183 cri_init: sigaction() failed: Invalid argument

Install mpich2 through conda
https://bugs.launchpad.net/ubuntu/+source/mpich2/+bug/1045326



    Install autoconfig
mkdir install
mkdir src
cd install
wget http://ftp.gnu.org/gnu/autoconf/autoconf-latest.tar.gz
tar -zvxf autoconf-latest.tar.gz
cd autoconf*
./configure --prefix=$HOME/src/autotools
make
make install
#make check
PATH=$HOME/src/autotools/bin:$PATH
export PATH=$PATH:$HOME/src/autotools/bin
# Put the same line in .bashrc


    Install automake
wget http://ftp.gnu.org/gnu/automake/automake-<version>.tar.gz
cd automake*
./configure --prefix=$HOME/src/autotools
make
make install
#make check


    Install valgrind (http://valgrind.org/downloads/repository.html)
cd ~/install
svn co svn://svn.valgrind.org/valgrind/trunk valgrind
cd valgrind
./autogen.sh
./configure --prefix=$HOME/valgrind
make
make install
