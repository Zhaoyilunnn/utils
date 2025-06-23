#!/bin/bash

# get base name of xxx.tex
base=$(basename $1 .tex)

# use pdflatex to convert LaTeX to PDF
pdflatex ${base}.tex

# pdfcrop to remove whitespace
pdfcrop ${base}.pdf temp && mv temp ${base}.pdf

# pdf2svg to convert PDF to SVG
pdf2svg ${base}.pdf ${base}.svg
