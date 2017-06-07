# Installation of ffmpeg

`ffmpeg` can be installed locally by using [ffmpegInstall.sh](../installScripts/ffmpegInstall.sh).
Note that occasionally `nasm` needs to be installed as well.

## Use in matplotlib
If your system searches for binaries in `$HOME/local/bin`, `matplotlib` should
be able to find `ffmpeg`. If not, there is a possibility to specify the
`ffmpeg` path in the `matplotlibrc` file. See

http://matplotlib.org/users/customizing.html

for details.

If not one can manually change the `rc` parameters directly in in `python`. See
for example

http://stackoverflow.com/questions/23074484/cannot-save-matplotlib-animation-with-ffmpeg

Writer example:

The `codec` in the example used assumes `x264` is installed.
If `codec` is unspecified `mpeg4` is usually the default.

```python
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
# * bitrate is set to -1 for automatic bit rate, if not a high number
#   should be set to get good quality
# * fps is sets how fast the animation is played
#   http://stackoverflow.com/questions/22010586/matplotlib-animation-duration
# * codec is by default mpeg4, but as this creates large files.
#   h264 is preferred.
writer = FFMpegWriter(bitrate = -1, fps=10, codec="h264")

ani.save('clock.mp4', writer, dpi=200)
plt.show()
```
