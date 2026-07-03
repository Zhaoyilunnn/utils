#!/usr/bin/env python3
"""Strip wrapper macros from LaTeX while preserving their contents.

Examples:
  strip_latex_macro.py --macro rev --in-place main.tex 0-abstract.tex
  strip_latex_macro.py --macro rev --check main.tex
  printf '\\rev{A \\cite{x} result}' | strip_latex_macro.py --stdin

The parser handles nested braces inside the macro body, such as
\\rev{text \\cite{key} and \\texttt{name}}.
"""

from __future__ import annotations

import argparse
import sys
from pathlib import Path


def strip_macro(text: str, macro: str) -> str:
    """Remove occurrences of \\macro{...}, preserving nested body text."""

    if not macro:
        raise ValueError("macro must not be empty")

    needle = "\\" + macro + "{"
    out: list[str] = []
    i = 0
    n = len(text)

    while i < n:
        if text.startswith(needle, i):
            i += len(needle)
            body, i = _read_balanced_body(text, i)
            out.append(strip_macro(body, macro))
        else:
            out.append(text[i])
            i += 1

    return "".join(out)


def _read_balanced_body(text: str, start: int) -> tuple[str, int]:
    body: list[str] = []
    depth = 1
    i = start
    n = len(text)

    while i < n and depth > 0:
        ch = text[i]

        if ch == "\\":
            if i + 1 < n:
                body.append(text[i : i + 2])
                i += 2
            else:
                body.append(ch)
                i += 1
            continue

        if ch == "{":
            depth += 1
            body.append(ch)
            i += 1
            continue

        if ch == "}":
            depth -= 1
            if depth == 0:
                i += 1
                break
            body.append(ch)
            i += 1
            continue

        body.append(ch)
        i += 1

    if depth != 0:
        raise ValueError("unbalanced macro body: missing closing brace")

    return "".join(body), i


def process_path(path: Path, macro: str, in_place: bool, check: bool) -> bool:
    old = path.read_text()
    new = strip_macro(old, macro)
    changed = new != old

    if check:
        if changed:
            print(f"{path}: would change", file=sys.stderr)
        return changed

    if in_place and changed:
        path.write_text(new)
    elif not in_place:
        sys.stdout.write(new)

    return changed


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Strip LaTeX wrapper macros such as \\rev{...}."
    )
    parser.add_argument("paths", nargs="*", type=Path, help="LaTeX files to process")
    parser.add_argument(
        "--macro",
        default="rev",
        help="macro name to strip, without leading backslash (default: rev)",
    )
    parser.add_argument(
        "--in-place",
        action="store_true",
        help="rewrite files in place",
    )
    parser.add_argument(
        "--check",
        action="store_true",
        help="exit with status 1 if any file would change",
    )
    parser.add_argument(
        "--stdin",
        action="store_true",
        help="read from stdin and write processed text to stdout",
    )
    return parser.parse_args()


def main() -> int:
    args = parse_args()

    if args.stdin:
        if args.paths:
            print("--stdin cannot be combined with file paths", file=sys.stderr)
            return 2
        sys.stdout.write(strip_macro(sys.stdin.read(), args.macro))
        return 0

    if not args.paths:
        print("provide at least one path or use --stdin", file=sys.stderr)
        return 2

    if args.check and args.in_place:
        print("--check cannot be combined with --in-place", file=sys.stderr)
        return 2

    if len(args.paths) > 1 and not args.in_place and not args.check:
        print("use --in-place or --check when processing multiple files", file=sys.stderr)
        return 2

    changed = False
    for path in args.paths:
        changed = process_path(path, args.macro, args.in_place, args.check) or changed

    if args.check and changed:
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
