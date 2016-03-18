#!/usr/bin/env bash
# Info:
# Burst a .pdf and save the pages to .svg.
#
# Requires:
# pdf2svg

# Burst the pdf
pdftk *.pdf burst

# Converting to svg as we maybe want to extract text
mkdir -p delme_svg
mkdir -p delme_pdf
mkdir -p figures/svg
for i in *.pdf;
do
    # ${i%.*} cuts the ,pdf part
    #http://stackoverflow.com/questions/965053/extract-filename-and-extension-in-bash
    echo $i to ${i%.*}.svg;
    pdf2svg $i ${i%.*}.svg;
    mv $i delme_pdf/$i;
    mv ${i%.*}.svg delme_svg/${i%.*}.svg;
done

# Delete the docdata file
rm -f doc_data.txt
