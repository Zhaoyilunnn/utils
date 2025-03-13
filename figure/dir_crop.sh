#!/bin/bash

# Check if directory is provided as argument
if [ $# -ne 1 ]; then
  echo "Usage: $0 <directory_path>"
  exit 1
fi

directory="$1"

# Check if directory exists
if [ ! -d "$directory" ]; then
  echo "Error: Directory '$directory' does not exist"
  exit 1
fi

# Check if pdfcrop is installed
if ! command -v pdfcrop &>/dev/null; then
  echo "Error: pdfcrop is not installed"
  exit 1
fi

# Process all PDF files in the directory
for file in "$directory"/*.pdf; do
  # Check if there are any PDF files
  if [ ! -e "$file" ]; then
    echo "No PDF files found in '$directory'"
    exit 0
  fi

  # Check if it's a regular file
  if [ -f "$file" ]; then
    echo "Processing: $file"
    # Crop PDF and overwrite original
    pdfcrop --margins '0 0 0 0' "$file" "$file" 2>/dev/null
    if [ $? -eq 0 ]; then
      echo "Successfully processed: $file"
    else
      echo "Error processing: $file"
    fi
  fi
done

echo "Done processing all PDFs"
