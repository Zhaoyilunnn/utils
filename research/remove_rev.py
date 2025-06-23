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

import sys
import os
import argparse


def process_line(
    line: str, in_rev: bool, nested: int, prefix: str
) -> tuple[str, int, bool]:
    new_line = line
    prefix_len = len(prefix)
    for i in range(len(line)):
        if line[i : i + prefix_len] == prefix:
            # find the start of a prefix
            if in_rev:
                raise ValueError(
                    f"Nested {prefix} found, which is not expected. The line is: "
                    + line
                )
            in_rev = True
            nested = 0

            j = i + prefix_len
            while j < len(line):
                if line[j] == "{":
                    nested += 1
                elif line[j] == "}":
                    if nested == 0:
                        in_rev = False
                        # found the end of the prefix
                        # delete the prefix and "}" from the line
                        new_line = (
                            line[:i]
                            + line[i + prefix_len : j]
                            + process_line(line[j + 1 :], in_rev, nested, prefix)[0]
                        )
                        break
                    else:
                        nested -= 1
                j += 1
            if in_rev:
                # if we reach here, it means we didn't find the closing "}"
                # but we still need to remove the prefix
                new_line = line[:i] + line[i + prefix_len :]
            break
        else:
            # if not in_rev, do nothing
            if in_rev:
                if line[i] == "{":
                    nested += 1
                elif line[i] == "}":
                    if nested == 0:
                        in_rev = False
                        # found the end of the prefix
                        # delete the "}" from the line
                        new_line = (
                            line[:i]
                            + process_line(line[i + 1 :], in_rev, nested, prefix)[0]
                        )
                    else:
                        nested -= 1
    return new_line, nested, in_rev


def process_file(file_path, prefix):
    """
    Remove the prefix tags (e.g. "\rev{}") and only retain the content
    """

    with open(file_path, "r", encoding="utf-8") as file:
        in_rev = False
        new_lines = []
        paragraph_buffer = []
        nested = 0
        for line in file:
            line = line.rstrip("\n")
            if line.startswith("%"):
                new_lines.append(line)  # Keep comments as they are
                continue
            line, nested, in_rev = process_line(line, in_rev, nested, prefix)
            if in_rev:
                paragraph_buffer.append(line)
            else:
                if paragraph_buffer:
                    # If we have a buffer, we need to flush it
                    new_lines.append("\n".join(paragraph_buffer))
                    paragraph_buffer = []
                new_lines.append(line)

    # write new lines to the file
    with open(file_path, "w", encoding="utf-8") as file:
        for line in new_lines:
            file.write(line + "\n")


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
        # If it's a single file
        if path.endswith(".tex"):
            print(f"Processing {path}")
            process_file(path, prefix)
            count = 1
        else:
            print(f"Skipping {path} - not a .tex file")
    else:
        # If it's a directory
        for root, dirs, files in os.walk(path):
            for file in files:
                if file.endswith(".tex"):
                    file_path = os.path.join(root, file)
                    print(f"Processing {file_path}")
                    process_file(file_path, prefix)
                    count += 1

    print(f"Finished processing {count} .tex file{'s' if count != 1 else ''}")
