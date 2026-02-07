#!/bin/bash

# Use pdftotext to convert all PDF files in the given directory to text files.
# Usage: ./pdftotext_dir.sh /path/to/pdf/directory
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 /path/to/pdf/directory"
  exit 1
fi

PDF_DIR="$1"
if [ ! -d "$PDF_DIR" ]; then
  echo "Error: Directory $PDF_DIR does not exist."
  exit 1
fi

for pdf_file in "$PDF_DIR"/*.pdf; do
  if [ -f "$pdf_file" ]; then
    text_file="${pdf_file%.pdf}.txt"
    pdftotext "$pdf_file" "$text_file"
    echo "Converted $pdf_file to $text_file"
  fi
done
