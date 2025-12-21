#!/usr/bin/env bash
set -euo pipefail

# Split a PDF into consecutive groups of N pages using pdftk.
# Usage:
#   pdf_split_groups.sh INPUT_PDF GROUP_SIZE [OUTPUT_PREFIX]
# - INPUT_PDF: path to source PDF
# - GROUP_SIZE: positive integer, number of pages per chunk
# - OUTPUT_PREFIX: optional output file prefix (default: basename of INPUT_PDF without extension)
#
# Outputs files named: ${OUTPUT_PREFIX}_1-10.pdf, ${OUTPUT_PREFIX}_11-20.pdf, ... (using page ranges)

usage() {
  echo "Usage: $(basename "$0") INPUT_PDF GROUP_SIZE [OUTPUT_PREFIX]" >&2
}

if [[ ${1:-} == "-h" || ${1:-} == "--help" ]]; then
  usage
  exit 0
fi

if [[ $# -lt 2 || $# -gt 3 ]]; then
  usage
  exit 1
fi

input_pdf=$1
group_size=$2
output_prefix=${3:-}

# Check dependencies
if ! command -v pdftk >/dev/null 2>&1; then
  echo "Error: pdftk not found. Please install pdftk." >&2
  exit 1
fi

# Validate input PDF
if [[ ! -f "$input_pdf" ]]; then
  echo "Error: input PDF not found: $input_pdf" >&2
  exit 1
fi

# Validate group size
if ! [[ "$group_size" =~ ^[0-9]+$ ]] || [[ "$group_size" -le 0 ]]; then
  echo "Error: GROUP_SIZE must be a positive integer." >&2
  exit 1
fi

# Derive default output prefix if not provided
if [[ -z "$output_prefix" ]]; then
  base_name=$(basename "$input_pdf")
  output_prefix="${base_name%.*}"
fi

# Determine total pages
# Using pdftk dump_data and parsing NumberOfPages
pages_line=$(pdftk "$input_pdf" dump_data | awk '/NumberOfPages/ {print $2; exit}')
if [[ -z "$pages_line" ]]; then
  echo "Error: could not determine number of pages in PDF." >&2
  exit 1
fi

total_pages=$pages_line

# Perform splitting
part=1
start=1
while [[ $start -le $total_pages ]]; do
  end=$((start + group_size - 1))
  if [[ $end -gt $total_pages ]]; then
    end=$total_pages
  fi

  out_file="${output_prefix}_${start}-${end}.pdf"
  echo "Creating $out_file (pages ${start}-${end})"
  # pdftk uses 1-based inclusive ranges
  pdftk "$input_pdf" cat ${start}-${end} output "$out_file"

  part=$((part + 1))
  start=$((end + 1))
done

echo "Done. Generated $((part - 1)) file(s)."

