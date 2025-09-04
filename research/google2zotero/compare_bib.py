import re
import sys
import Levenshtein


def clean_title(title):
    # Remove all curly braces (including nested)
    title = re.sub(r"[{}]", "", title)
    title = re.sub(r"\$.*?\$", "", title)
    title = re.sub(r"\\\(.*?\\\)", "", title)
    # Remove special characters
    title = re.sub(r"[^a-zA-Z0-9\s]", "", title)
    return title.lower().strip()


def parse_bib_entries(bibfile):
    """Parse bib file into a dict: key -> (title, entry_text)"""
    entries_dict = {}
    with open(bibfile, "r", encoding="utf-8") as f:
        content = f.read()
    entries = content.split("@")[1:]
    for entry in entries:
        lines = entry.splitlines()
        header = lines[0]
        try:
            key = header.split("{", 1)[1].strip().strip(",")
        except:
            continue
        title = ""
        in_title = False
        title_lines = []
        for line in lines:
            # Start of title field
            if not in_title and line.strip().lower().startswith("title"):
                parts = line.split("=", 1)
                if len(parts) == 2:
                    after_eq = parts[1].lstrip()
                    if after_eq.startswith("{") or after_eq.startswith('"'):
                        in_title = True
                        after_eq = after_eq.lstrip("{").lstrip('"')
                        if (
                            after_eq.endswith("},")
                            or after_eq.endswith('",')
                            or after_eq.endswith("}")
                            or after_eq.endswith('"')
                        ):
                            after_eq = (
                                after_eq.rstrip("},")
                                .rstrip('",')
                                .rstrip("}")
                                .rstrip('"')
                            )
                            title_lines.append(after_eq)
                            in_title = False
                            break
                        else:
                            title_lines.append(after_eq)
                    else:
                        continue
            elif in_title:
                line_stripped = line.strip()
                if (
                    line_stripped.endswith("},")
                    or line_stripped.endswith('",')
                    or line_stripped.endswith("}")
                    or line_stripped.endswith('"')
                ):
                    line_stripped = (
                        line_stripped.rstrip("},").rstrip('",').rstrip("}").rstrip('"')
                    )
                    title_lines.append(line_stripped)
                    in_title = False
                    break
                else:
                    title_lines.append(line_stripped)
        if title_lines:
            title = " ".join(title_lines)
            entries_dict[key] = (clean_title(title), "@" + entry.strip() + "\n")
        else:
            entries_dict[key] = ("", "@" + entry.strip() + "\n")
    return entries_dict


def compare_titles(a_titles, b_titles):
    missing = []
    for a_key, a_title in a_titles.items():
        found = False
        for b_title in b_titles.values():
            if Levenshtein.distance(a_title, b_title) <= 2:
                found = True
                break
        if not found:
            missing.append((a_key, a_title))
    return missing


def build_merged_bib(a_bib, b_bib, output_file):
    """
    For each entry in A:
      - If its title matches (distance <= 2) any entry in B, use B's entry.
      - Otherwise, use A's entry.
    Write all selected entries to output_file.
    If there are duplicate entries (by key), only keep one.
    """
    a_entries = parse_bib_entries(a_bib)
    b_entries = parse_bib_entries(b_bib)

    used_keys = set()
    merged_entries = []
    key_to_entry = {}

    for a_key, (a_title, a_entry) in a_entries.items():
        found = False
        for b_key, (b_title, b_entry) in b_entries.items():
            if a_title and b_title and Levenshtein.distance(a_title, b_title) <= 2:
                # Use B's entry
                if b_key not in used_keys:
                    key_to_entry[b_key] = b_entry
                    used_keys.add(b_key)
                found = True
                break
        if not found:
            if a_key not in used_keys:
                key_to_entry[a_key] = a_entry
                used_keys.add(a_key)

    # Only keep one entry per key
    merged_entries = list(key_to_entry.values())

    with open(output_file, "w", encoding="utf-8") as f:
        for entry in merged_entries:
            f.write(entry.strip() + "\n\n")
    print(f"Merged bib written to {output_file}")


if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("用法: python compare_bib.py A.bib B.bib merged.bib")
        sys.exit(1)
    A, B, OUT = sys.argv[1], sys.argv[2], sys.argv[3]
    a_entries = parse_bib_entries(A)
    b_entries = parse_bib_entries(B)
    a_titles = {k: v[0] for k, v in a_entries.items()}
    b_titles = {k: v[0] for k, v in b_entries.items()}
    missing = compare_titles(a_titles, b_titles)
    with open("diff.txt", "w", encoding="utf-8") as f:
        for key, title in missing:
            f.write(f"{key}: {title}\n")
    print("结果已写入 diff.txt")
    for key, title in missing:
        print(f"{key}: {title}")
    build_merged_bib(A, B, OUT)
