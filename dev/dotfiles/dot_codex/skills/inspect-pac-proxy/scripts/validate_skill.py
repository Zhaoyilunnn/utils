#!/usr/bin/env python3
"""
Minimal validator for this skill that avoids external dependencies.
Checks:
- SKILL.md exists
- frontmatter is present
- frontmatter contains name and description
- skill name is hyphen-case
"""

from pathlib import Path
import re
import sys


MAX_NAME_LENGTH = 64


def fail(message: str) -> int:
    print(message)
    return 1


def main() -> int:
    root = Path(sys.argv[1] if len(sys.argv) > 1 else ".").resolve()
    skill_md = root / "SKILL.md"
    if not skill_md.exists():
        return fail("SKILL.md not found")

    content = skill_md.read_text(encoding="utf-8")
    match = re.match(r"^---\n(.*?)\n---\n", content, re.DOTALL)
    if not match:
        return fail("Invalid or missing YAML frontmatter")

    frontmatter = match.group(1)
    name_match = re.search(r"^name:\s*(.+?)\s*$", frontmatter, re.MULTILINE)
    description_match = re.search(r"^description:\s*(.+?)\s*$", frontmatter, re.MULTILINE)

    if not name_match:
        return fail("Missing name in frontmatter")
    if not description_match:
        return fail("Missing description in frontmatter")

    name = name_match.group(1).strip().strip("'\"")
    description = description_match.group(1).strip().strip("'\"")

    if not re.fullmatch(r"[a-z0-9-]+", name):
        return fail("Name must use lowercase letters, digits, and hyphens only")
    if name.startswith("-") or name.endswith("-") or "--" in name:
        return fail("Name cannot start/end with hyphen or contain consecutive hyphens")
    if len(name) > MAX_NAME_LENGTH:
        return fail(f"Name is too long: {len(name)} > {MAX_NAME_LENGTH}")
    if not description:
        return fail("Description cannot be empty")
    if "<" in description or ">" in description:
        return fail("Description cannot contain angle brackets")

    print("Skill is valid (fallback validator).")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
