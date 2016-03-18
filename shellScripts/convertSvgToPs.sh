#!/usr/bin/env bash
# Info:
# Converts svg/*.svg to ps*./ps
#
# Requires:
# uniconvertor

# Make the ps folder
mkdir -p ps

# cd into svg
cd svg

for i in *.svg;
do
    # ${i%.*} cuts the ,pdf part
    #http://stackoverflow.com/questions/965053/extract-filename-and-extension-in-bash
    echo $i to ${i%.*}.ps;
    uniconvertor $i ${i%.*}.ps;
    mv ${i%.*}.ps ../ps/${i%.*}.ps;
done

# cd out
cd ..
