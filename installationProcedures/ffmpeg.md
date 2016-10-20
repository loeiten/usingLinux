# Installation of ffmpeg

This guide shows how on could build ffmpeg locally.

- [Building ffmpeg](building-ffmpeg)
- [Building yasm](building-yasm)
- [Use in matplotlib](Use in matplotlib)

## Building ffmpeg

```sh
cd $HOME
mkdir local
mkdir install
cd install
wget http://ffmpeg.org/releases/ffmpeg-3.1.4.tar.bz2
tar -xvf ffmpeg-3.1.4.tar.bz2
cd ffmpeg-3.1.4
./configure --prefix=$HOME/local
```

If an error occurs that `yasm` is too old or non-existing, see
[build yasm](#build-yasm), if not proceed with

```sh
make
# Optional
# make check
make install
```
## Build yasm

```sh
cd $HOME
mkdir local
mkdir install
cd install
wget http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz
tar -xvzf yasm-1.3.0.tar.gz
cd yasm-1.3.0
./configure --prefix=$HOME/local
make
# Optional
# make check
make install
```

## Use in matplotlib
If your system searches for binaries in `$HOME/local/bin`, `matplotlib` should
be able to find `ffmpeg`. If not, there is a possibility to specify the
`ffmpeg` path in the `matplotlibrc` file. See

http://matplotlib.org/users/customizing.html

for details.

If not one can manually change the `rc` parameters directly in in `python`. See
for example

http://stackoverflow.com/questions/23074484/cannot-save-matplotlib-animation-with-ffmpeg
