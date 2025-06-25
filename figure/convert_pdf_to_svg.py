#!/usr/bin/env python3
"""
Convert PDF files to SVG using pdf2svg.
Usage:
    convert_pdf_to_svg.py <directory>
    convert_pdf_to_svg.py <file.pdf>
    convert_pdf_to_svg.py <prefix>

If a directory is given, all `.pdf` files in that directory will be converted.
If a single `.pdf` file is given, only that file will be converted.
If a prefix is given, all files in the current working directory whose names
start with that prefix and end in `.pdf` will be converted.
The output SVGs will be placed alongside their source PDFs, keeping the same base name.
"""

import os
import sys
import glob
import subprocess


def convert_pdf_to_svg(pdf_path: str) -> None:
    """
    Run pdf2svg on a single PDF file to produce an SVG with the same basename.
    """
    directory, filename = os.path.split(pdf_path)
    base, _ = os.path.splitext(filename)
    svg_path = os.path.join(directory or ".", f"{base}.svg")

    try:
        subprocess.run(["pdf2svg", pdf_path, svg_path], check=True)
        print(f"Converted: {pdf_path} -> {svg_path}")
    except FileNotFoundError:
        print(
            "Error: 'pdf2svg' command not found. Please install pdf2svg.",
            file=sys.stderr,
        )
        sys.exit(1)
    except subprocess.CalledProcessError as e:
        print(f"Error converting {pdf_path}: {e}", file=sys.stderr)


def gather_pdfs(arg: str) -> list[str]:
    """
    Determine which PDFs to convert based on the argument:
      - existing directory: all .pdf files within
      - existing .pdf file: that single file
      - otherwise: treat arg as prefix, glob for arg*.pdf in cwd
    """
    if os.path.isdir(arg):
        # All PDFs in the directory
        return [
            os.path.join(arg, f) for f in os.listdir(arg) if f.lower().endswith(".pdf")
        ]
    elif os.path.isfile(arg) and arg.lower().endswith(".pdf"):
        # Single PDF file
        return [arg]
    else:
        # Prefix glob in current working directory
        return sorted(glob.glob(f"{arg}*.pdf"))


def main():
    if len(sys.argv) != 2:
        print(__doc__)
        sys.exit(1)

    arg = sys.argv[1]
    pdfs = gather_pdfs(arg)

    if not pdfs:
        print(f"No PDF files found for '{arg}'.", file=sys.stderr)
        sys.exit(1)

    for pdf in pdfs:
        convert_pdf_to_svg(pdf)


if __name__ == "__main__":
    main()
