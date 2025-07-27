import re
import argparse
import sys


def parse_author_line(line):
    # Example format: Name (Affiliation) <email>
    match = re.match(r"^([^()]+)\(([^)]+)\)\s*<([^>]+)>", line.strip())
    if not match:
        return None
    name, affiliation, email = match.groups()
    return {
        "name": name.strip(),
        "affiliation": affiliation.strip(),
        "email": email.strip(),
    }


def infer_city_country(affiliation):
    # You can extend this dictionary as needed for more institutions
    lookup = [
        (
            "Beijing",
            [
                "Institute of Computing Technology",
                "Chinese Academy of Sciences",
                "University of Chinese Academy of Sciences",
            ],
        ),
        (
            "Changsha",
            [
                "National University of Defense Technology",
                "China Greatwall Quantum Laboratory",
            ],
        ),
        ("Shanghai", ["East China Normal University"]),
        (
            "Hefei",
            [
                "University of Science and Technology of China",
                "Hefei National Laboratory",
            ],
        ),
    ]
    for city, keywords in lookup:
        for kw in keywords:
            if kw.lower() in affiliation.lower():
                return city, "China"
    return "City", "Country"


def author_to_latex(author):
    city, country = infer_city_country(author["affiliation"])
    return f"""\\author{{{author["name"]}}}
\\affiliation{{
  \\institution{{{author["affiliation"]}}}
  \\city{{{city}}}
  \\country{{{country}}}
}}
\\email{{{author["email"]}}}
"""


def main():
    parser = argparse.ArgumentParser(description="Convert authors.txt to LaTeX format.")
    parser.add_argument("input_file", help="Path to the authors.txt file")
    parser.add_argument(
        "-o", "--output", help="Output file (default: stdout)", default=None
    )
    args = parser.parse_args()

    with open(args.input_file, encoding="utf-8") as f:
        input_lines = [line.strip() for line in f if line.strip()]

    latex_blocks = []
    for line in input_lines:
        author = parse_author_line(line)
        if author:
            latex_blocks.append(author_to_latex(author))
        else:
            print(f"Warning: Line does not match expected format: {line}", file=sys.stderr)

    output_text = "\n".join(latex_blocks)

    if args.output:
        with open(args.output, "w", encoding="utf-8") as out:
            out.write(output_text)
    else:
        print(output_text)


if __name__ == "__main__":
    main()
