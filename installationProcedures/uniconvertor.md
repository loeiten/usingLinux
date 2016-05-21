# Install uniconvertor

**NOTE**: 
* `uniconvertor` is currently only available in `py27`
* After certain updates it looks like `inkscape` is a superior alternative. Type `man inkscape` for synopsis.
* Had some issues with converting when file contains rasterized graphics. Looks like this is due to bad installation scripts.

Search for `python-uniconvertor` in the software manager

If **NOT** found:

1. Download `uniconvertor` and `sk1libs` from http://sk1project.org/modules.php?name=Products&product=uniconvertor&op=download
2. `sudo apt-get install libfreetype6-dev libjpeg62-dev liblcms-dev libz-dev libjpeg8-dev`
3. Follow instructions in `README` in sk1libs-0.9.1.tar.gz
  * That is `python setup.py install`

Possible error:

```
#include <freetype/fterrors.h>
```
This is addressed on
https://gist.github.com/shingonoide/8172291

The solution is to

```
cd /usr/include
ln -s freetype2 freetype
```
Before installing the package
