#!/bin/sh

# Usage
# sh pdf_crop.sh <page number> <pdf file without ext> <output file name>

pdftk A="$2-temp.pdf" cat A$1-$1 output "$3.pdf"
mv "$3.pdf" ./
