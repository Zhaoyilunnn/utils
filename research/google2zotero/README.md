# Replace Paper Citations

Replace paper citations from one `.bib` file to another.

## Requirements

- <https://pypi.org/project/python-Levenshtein/>

## Usage

All scripts should be run in paper root directory and assume all `.tex` files are in the root directory.

1. Extract cited papers from one `.bib`

```
python extract_citations.py
```

2. (Optionally) Compare and merge two `.bib` files

If old in new, then keep new in merged, otherwise add old to merged.

```
python compare_bib.py old.bib new.bib merged.bib
```

3. Replace citations in `.tex` files

```
python replace_citations.py old.bib new.bib
```
