import os
import re


def extract_citations_from_tex():
    citation_pattern = re.compile(r"\\cite\{([^}]*)\}")
    citations = set()
    for filename in os.listdir("."):
        if filename.endswith(".tex"):
            with open(filename, "r", encoding="utf-8") as f:
                content = f.read()
                matches = citation_pattern.findall(content)
                for match in matches:
                    keys = [key.strip() for key in match.split(",")]
                    citations.update(keys)
    return citations


def extract_entries_from_bib(bibfile, keys):
    entries = {}
    with open(bibfile, "r", encoding="utf-8") as f:
        content = f.read()
    # split by @
    raw_entries = content.split("@")
    for raw in raw_entries[1:]:
        header, body = raw.split("\n", 1)
        entry_type, entry_key = header.strip().split("{", 1)
        entry_key = entry_key.strip().strip(",")
        if entry_key in keys:
            entries[entry_key] = "@" + raw
    return entries


if __name__ == "__main__":
    bibfile = input("请输入目标bib文件路径: ").strip()
    citations = extract_citations_from_tex()
    print(f"在tex文件中找到 {len(citations)} 个引用")

    entries = extract_entries_from_bib(bibfile, citations)
    with open("used_references.bib", "w", encoding="utf-8") as f:
        for entry in entries.values():
            f.write(entry.strip() + "\n\n")
    print("已生成 used_references.bib")
