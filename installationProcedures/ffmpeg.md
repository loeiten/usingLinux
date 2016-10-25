# Installation of ffmpeg

This guide shows how on could build ffmpeg locally.

- [Building ffmpeg](building-ffmpeg)
- [Building yasm](building-yasm)
- [Building x264](building-x264)
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
```

If you do not care about having smaller files, continue with

```sh
./configure --prefix=$HOME/local
```

If you would like a good compression, first make sure that
[x256 is built](building-x264), and proceed with

```sh
./configure --prefix=$HOME/local --enable-gpl --enable-libx264 \
            --extra-ldflags=-L$HOME/local/lib \
            --extra-cflags=-I$HOME/local/include
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

## Building x264
Make sure that [yasm](building-yasm), and proceed with

```sh
cd $HOME
cd install
git clone git://git.videolan.org/x264.git
cd x264/
./configure --prefix=$HOME/local --enable-static --enable-shared
make
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

Writer example (the `codec` in the example used assumes `x264` is installed, if
`codec` is unspecified `mpeg4` is usually the default):

```py
#!/usr/bin/env python

"""
Example of animation plot

Source:
http://stackoverflow.com/questions/22010586/matplotlib-animation-duration
"""

import numpy as np
import matplotlib.pyplot as plt
import matplotlib.animation as animation

fig = plt.figure(figsize=(16, 12))
ax = fig.add_subplot(111)
# You can initialize this with whatever
im = ax.imshow(np.random.rand(6, 10), cmap='bone_r', interpolation='nearest')

def animate(i):
    aux = np.zeros(60)
    aux[i] = 1
    image_clock = np.reshape(aux, (6, 10))
    im.set_array(image_clock)

ani = animation.FuncAnimation(fig, animate, frames=60, interval=1000)

FFMpegWriter = animation.writers['ffmpeg']
# * bitrate is set high in order to have ok quality
# * fps is sets how fast
#   http://stackoverflow.com/questions/22010586/matplotlib-animation-duration
# * codec is by default mpeg4, but as this creates large files.
#   h264 is preferred.
writer = FFMpegWriter(bitrate = 10000, fps=10, codec="h264")

ani.save('clock.mp4', writer, dpi=200)
plt.show()
```
