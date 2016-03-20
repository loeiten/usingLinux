#!/bin/bash
# Info:
# Recursively changes the extension of files
#
# Usage:
# ./changeExtension extension1 extension2
shopt -s globstar
for f in **/*.$1
do
    [ -f "$f" ] && mv -v "$f" "${f%$1}$2"
done
