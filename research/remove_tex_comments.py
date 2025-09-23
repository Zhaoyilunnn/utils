import os

EXCLUDE_FILES = {"main.tex"}


def remove_comments_from_tex_file(filename):
    with open(filename, "r", encoding="utf-8") as f:
        lines = f.readlines()
    new_lines = []
    for line in lines:
        # keep original empty lines
        if line.strip() == "":
            new_lines.append("\n")
            continue

        # Remove everything after % unless the % is in a verbatim environment
        # For simplicity, we ignore verbatim environments here
        # "\\%" means percent sign in LaTeX
        if "%" in line and "\\%" not in line:
            # Only keep content before %
            line = line.split("%", 1)[0]
        # Remove trailing whitespace
        line = line.rstrip()
        # Only add non-empty lines
        if line.strip() != "":
            new_lines.append(line + "\n")
    with open(filename, "w", encoding="utf-8") as f:
        f.writelines(new_lines)


def main():
    for fname in os.listdir("."):
        if fname in EXCLUDE_FILES:
            continue
        if fname.endswith(".tex") and os.path.isfile(fname):
            remove_comments_from_tex_file(fname)
            print(f"Processed: {fname}")


if __name__ == "__main__":
    main()
