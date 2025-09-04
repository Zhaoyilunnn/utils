import os
import re
import sys
import Levenshtein


def clean_title(title):
    # 去掉所有花括号（包括嵌套）
    title = re.sub(r"[{}]", "", title)
    title = re.sub(r"\$.*?\$", "", title)
    title = re.sub(r"\\\(.*?\\\)", "", title)
    # 去掉特殊字符
    title = re.sub(r"[^a-zA-Z0-9\s]", "", title)
    return title.lower().strip()


def parse_bib_titles(bibfile):
    titles = {}
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
                # Find the '=' sign and start collecting after it
                parts = line.split("=", 1)
                if len(parts) == 2:
                    after_eq = parts[1].lstrip()
                    # Check if title starts with '{' or '"'
                    if after_eq.startswith("{") or after_eq.startswith('"'):
                        in_title = True
                        # Remove starting '{' or '"'
                        after_eq = after_eq.lstrip("{").lstrip('"')
                        # Check if ends on same line
                        if (
                            after_eq.endswith("},")
                            or after_eq.endswith('",')
                            or after_eq.endswith("}")
                            or after_eq.endswith('"')
                        ):
                            # Remove ending '}' or '"'
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
                        # Unexpected format, skip
                        continue
            elif in_title:
                # Continue collecting title lines
                line_stripped = line.strip()
                # Check if this line ends the title
                if (
                    line_stripped.endswith("},")
                    or line_stripped.endswith('",')
                    or line_stripped.endswith("}")
                    or line_stripped.endswith('"')
                ):
                    # Remove ending '}' or '"'
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
            titles[key] = clean_title(title)
    return titles


def build_mapping(a_titles, b_titles):
    mapping = {}
    for a_key, a_title in a_titles.items():
        best_match = None
        best_dist = 3  # only accept ≤ 2
        for b_key, b_title in b_titles.items():
            dist = Levenshtein.distance(a_title, b_title)
            if dist < best_dist:
                best_dist = dist
                best_match = b_key
        if best_match is not None:
            mapping[a_key] = best_match
    return mapping


def replace_in_tex(mapping):
    cite_pattern = re.compile(r"\\cite\{([^}]*)\}")
    for filename in os.listdir("."):
        if filename.endswith(".tex"):
            with open(filename, "r", encoding="utf-8") as f:
                content = f.read()

            def replacer(match):
                keys = [k.strip() for k in match.group(1).split(",")]
                new_keys = []
                for k in keys:
                    if k in mapping:
                        new_keys.append(mapping[k])
                    else:
                        print(f"Key not found in mapping: {k}")
                        new_keys.append(k)
                return f"\\cite{{{','.join(new_keys)}}}"

            new_content = cite_pattern.sub(replacer, content)
            with open(filename, "w", encoding="utf-8") as f:
                f.write(new_content)
            print(f"已处理 {filename}")


if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("用法: python replace_citations.py A.bib B.bib")
        sys.exit(1)
    A, B = sys.argv[1], sys.argv[2]
    a_titles = parse_bib_titles(A)
    b_titles = parse_bib_titles(B)
    mapping = build_mapping(a_titles, b_titles)
    print(f"建立了 {len(mapping)} 个 entry 映射")
    replace_in_tex(mapping)
