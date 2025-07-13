import re
from collections import defaultdict


def parse_markdown_table(md_text):
    lines = md_text.strip().splitlines()
    # Find the header and separator lines
    header_idx = None
    for i, line in enumerate(lines):
        if re.match(r"^\s*\|", line):
            if header_idx is None:
                header_idx = i
            elif re.match(r"^\s*\|[\s-]+\|", line):
                # This is the separator line
                start_idx = header_idx + 2
                break
    else:
        raise ValueError("No markdown table found")

    # Parse the table rows, carrying forward the last non-empty type
    rows = []
    last_type = "Other"
    for line in lines[start_idx:]:
        if not line.strip().startswith("|"):
            continue
        # Split by |, remove first and last empty
        parts = [p.strip() for p in line.strip().split("|")[1:-1]]
        if len(parts) < 3:
            parts += [""] * (3 - len(parts))
        type_, name, desc = parts
        if type_:
            last_type = type_
        else:
            type_ = last_type
        rows.append((type_, name, desc))
    return rows


def group_by_type(rows):
    grouped = defaultdict(list)
    for row in rows:
        type_, name, desc = row
        grouped[type_].append((name, desc))
    return grouped


def format_markdown_list(grouped):
    out = []
    for type_ in sorted(grouped.keys()):
        out.append(f"### {type_}")
        for name, desc in grouped[type_]:
            out.append(f"- {name}, {desc}")
        out.append("")  # blank line between groups
    return "\n".join(out)


def main():
    import sys

    if len(sys.argv) < 2:
        print("Usage: python markdown_table_to_list.py <input.md>")
        return
    with open(sys.argv[1], encoding="utf-8") as f:
        md_text = f.read()
    rows = parse_markdown_table(md_text)
    grouped = group_by_type(rows)
    md_list = format_markdown_list(grouped)
    print(md_list)


if __name__ == "__main__":
    main()
