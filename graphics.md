# Graphics

* [Tools](#tools)
* [Inkscape tricks](#inkscape-tricks)
* [Animated gifs](#animated-gifs)
* [Extract vectorized figures](#extract-vectorized-figures)
* [Removing background from 3D matplotlib plots](#removing-background-from-3D-matplotlib-plots)

## Tools

1. inkscape - when dealing with vectorized graphics
2. blender - hard core 3D graphics and animations

## Inkscape tricks

* [Over-all tutorial](#over-all-tutorial)
* [Latex in inkscape](#latex-in-inkscape)
* [Delete a node](#delete-a-node)
* [Crop bitmap](#crop-bitmap)
* [Vectorize](#vectorize)

### Over-all tutorial

http://www.microugly.com/inkscape-quickguide/

### Latex in inkscape
texText is your solution

http://pav.iki.fi/software/textext/

Installation

http://www.timteatro.net/2010/08/05/textext-for-math-in-inkscape/

Errors may occur you try to make the equations in an already existing `.svg`
file

It is possible to write the equations in one window, and copy them to the
document of interest. Eventually on can save them as an `.svg`, and use
`Import` in inkscape

### Delete a node
* `DEL` - Deletes only node
* `CTRL + DEL` - Deletes node + path

### Crop bitmap

1. Draw a shape on your bitmap, masking the part you want to keep.
2. Select the shape and the bitmap and use Object>Clip>Set.
3. Select the resulting object and make a bitmap copy (Alt+B).
4. Select the bitmap copy and trace.

https://answers.launchpad.net/inkscape/+question/183741

### Vectorize
1. Ctrl+click to select image (sometimes it's hidden as an object)
2. Select bitmap
3. Path
4. Trace bitmap

If there are gradients, it is tricky, but doable, you can
* Can do them yourself
* Use `Fill object` (remebmber set high treshold)
* Make linear gradient and add more points in the gradient

http://www.inkscapeforum.com/viewtopic.php?f=5&t=11314

http://vector-conversions.com/graphics/vector/vectorizing-full-color-images.html

http://graphicdesign.stackexchange.com/questions/3643/how-to-convert-a-raster-image-into-vector

http://vector.tutsplus.com/tutorials/illustration/tips-for-working-with-the-gradient-mesh-tool-in-illustrator/

## Extract vectorized figures
See [extractImages.sh](shellScripts/extractImages.sh) on how to save the pages
of a `pdf` document to `svg` files. When have the `svg` files, one can

1. Open in `inkscape`
2. Rubber select the figure: `Shift+Drag`
3. Invert selection: `!`
4. Delete all other: `Del`
5. Resize in "Document properties": `Ctrl+Shift+D`
6. Under `Costum size`, open `Resize page to content`, then
   `Resize page to drawing or selection`

## Animated gifs
See [pngToGif.sh](shellScripts/pngToGif.sh) on how to make a `gif` from a group
of `png`s.

## Removing background from 3D matplotlib plots

Save as .eps
Use inkscape to remove white background
