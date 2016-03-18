#!/usr/bin/env bash
# Info:
# Converts all *.gif in the current folder into *.mp4
#
# Requires:
# FFmpeg

# Bash script
# http://www.cyberciti.biz/faq/bash-loop-over-file/
# ffmpeg
# https://github.com/FFmpeg/FFmpeg

# Make folder
mkdir mp4

# Loop over all files
for f in *.gif
do
    echo "Working with $f"
    # Get file extension
    # http://stackoverflow.com/questions/965053/extract-filename-and-extension-in-bash
    echo "ffmpeg -f gif -i $f mp4/${f%.*}.mp4"
    echo ""
    ffmpeg -f gif -i "$f" mp4/"${f%.*}".mp4
done
