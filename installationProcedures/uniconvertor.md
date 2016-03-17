# Install uniconvertor

Search for `python-uniconvertor` in the software manager

If **NOT** found:

1. Download `uniconvertor` and `sk1libs` from http://sk1project.org/modules.php?name=Products&product=uniconvertor&op=download
2. `sudo apt-get install libfreetype6-dev libjpeg62-dev liblcms-dev libz-dev`
3. Follow instructions in `README` in sk1libs-0.9.1.tar.gz

Possible error:

```
#include <freetype/fterrors.h>
```
This is adressed on
https://gist.github.com/shingonoide/8172291

The solution is to

```
cd /usr/include
ln -s freetype2 freetype
```
Before installing the package
