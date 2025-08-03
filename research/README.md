# Search papers in DBLP

See help information through

```
bash find_papers.sh
```

# Convert HotCRP Author List to ACM LaTeX Format

The script `hotcrp_author_to_acm_latex.py` converts a list of authors (as exported from HotCRP) into the ACM LaTeX author format.

## Usage

```
python hotcrp_author_to_acm_latex.py authors.txt
```

By default, the output is printed to stdout.

To save the output to a file, use the `-o` or `--output` option:

```
python hotcrp_author_to_acm_latex.py authors.txt -o authors.tex
```

- `authors.txt` should contain one author per line in the format:
  ```
  Name (Affiliation) <email>
  ```
  Example:
  ```
  Alice Smith (Institute of Computing Technology) <alice@example.com>
  Bob Lee (National University of Defense Technology) <bob@example.com>
  ```

The script will attempt to infer the city and country for common Chinese institutions. For unknown affiliations, it will use "City" and "Country" as placeholders.
