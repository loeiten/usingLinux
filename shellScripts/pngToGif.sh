#!/usr/bin/env bash
# Info:
# Set a transparent background to png-files, auto-crops them, and collect them
# as a gif
#
# Usage:
# $./clipAndTransparent rootname bgcolor
#
# Requires:
# imagemagick

# Set transparent
# http://graphicdesign.stackexchange.com/questions/16120/batch-replacing-color-with-transparency
# Input parameter in shell scripts
# http://osr600doc.sco.com/en/SHL_automate/_Passing_to_shell_script.html
for i in $1* ; do echo $i ; convert -transparent $2 $i trans_$i; done

# Crop the image
# http://www.imagemagick.org/Usage/crop/#trim
for i in trans* ; do echo $i ; convert -trim +repage $i trimmed_trans_$i; done

# Make animated gif
# If number of loops is set to 0, and infinite loop is created
convert -delay 10 -loop 0 trimmed_trans_*.png anim.gif

# Delete temporary files
rm *trans_*

# Make ffmpeg movie
# http://docs.enthought.com/mayavi/mayavi/tips.html
# ffmpeg -f image2 -r 10 -i rootname%03d.png -sameq anim.mov -pass 2
