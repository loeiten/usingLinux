#!/usr/bin/env bash

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
    # -r is the fps, if this is not set, it will skip the last frames
    # -b is the bitrate, if this is not set, bad quality is expected
    echo "ffmpeg gif -i $f -r 30 -b 4096k mp4/${f%.*}.mp4"
    echo ""
    ffmpeg -f gif -i "$f"  -r 30 -b 4096k mp4/"${f%.*}".mp4
done
