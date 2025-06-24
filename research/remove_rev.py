"""
LaTeX Revision Tag Remover

This script processes LaTeX (.tex) files to remove specific markup tags
(by default '\rev{...}') while preserving the content inside them.

It can process either a single file or recursively walk through a directory,
handling all .tex files it finds. The script properly manages nested braces,
preserves comments, and maintains the structure of the documents.

Useful for preparing final versions of LaTeX documents after the revision process
is complete, by stripping revision markup while keeping the revised content.
"""

import os
import argparse


def remove_tags(s: str, prefix: str) -> str:
    """
    Remove the prefix tags (e.g., \rev{...}) and retain the content inside them.
    Handles nested braces and preserves comments.
    """
    result = []
    i = 0
    plen = len(prefix)
    while i < len(s):
        if s[i] == "%":
            # Preserve comments to end of line
            end = s.find("\n", i)
            if end == -1:
                result.append(s[i:])
                break
            result.append(s[i : end + 1])
            i = end + 1
        elif s.startswith(prefix, i):
            # Found prefix (which includes the '{'), so parse until matching '}'
            i += plen
            brace_level = 1
            start = i
            while i < len(s) and brace_level > 0:
                if s[i] == "%":
                    # skip comment to end of line inside the tag
                    end = s.find("\n", i)
                    if end == -1:
                        i = len(s)
                        break
                    i = end + 1
                elif s[i] == "{":
                    brace_level += 1
                    i += 1
                elif s[i] == "}":
                    brace_level -= 1
                    if brace_level == 0:
                        # Recursively process the inside content
                        inner = remove_tags(s[start:i], prefix)
                        result.append(inner)
                        i += 1
                        break
                    else:
                        i += 1
                else:
                    i += 1
        else:
            # Regular character
            result.append(s[i])
            i += 1
    return "".join(result)


def process_content(content: str, prefix: str) -> str:
    """
    Remove the prefix tags (e.g., \rev{...}) and retain the content inside them.
    Handles nested braces and preserves comments.
    """
    return remove_tags(content, prefix)


def process_file(file_path: str, prefix: str):
    """
    Process a single .tex file to remove the prefix tags.
    """
    with open(file_path, "r", encoding="utf-8") as f:
        content = f.read()

    new_content = process_content(content, prefix)

    with open(file_path, "w", encoding="utf-8") as f:
        f.write(new_content)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Remove tags from TeX files")
    parser.add_argument(
        "path",
        nargs="?",
        default=".",
        help="Path to a single .tex file or a directory containing .tex files (default: current directory)",
    )
    parser.add_argument(
        "--prefix",
        "-p",
        default="\\rev{",
        help="Prefix to remove from the text (default: \\rev{)",
    )
    args = parser.parse_args()

    path = args.path
    prefix = args.prefix
    count = 0

    if os.path.isfile(path):
        if path.endswith(".tex"):
            print(f"Processing {path}")
            process_file(path, prefix)
            count = 1
        else:
            print(f"Skipping {path} - not a .tex file")
    else:
        for root, dirs, files in os.walk(path):
            for file in files:
                if file.endswith(".tex"):
                    tex_path = os.path.join(root, file)
                    print(f"Processing {tex_path}")
                    process_file(tex_path, prefix)
                    count += 1

    print(f"Finished processing {count} .tex file{'s' if count != 1 else ''}")
