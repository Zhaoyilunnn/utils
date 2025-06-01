# Content

- `dev`:  development related configurations.
  - Contains neovim/vim configurations and development tools
  - Tools include a GitHub Issue fetcher (`dev/tools/fetch_github_issue.py`) to download issues and comments for offline viewing
- `gist`: legacy gist related scripts.
- `figure`: figure related scripts.
- `research`: research related scripts.
- `windows`: utility scripts for windows.

## Tools Highlight

### GitHub Issue Fetcher
The `dev/tools/fetch_github_issue.py` script allows you to download GitHub issues and all their comments to a text file for offline reference.

Usage:
```bash
python dev/tools/fetch_github_issue.py https://github.com/owner/repo/issues/123
```

This generates a file named `issue_owner_repo_123.txt` containing the issue title, description, and all comments in chronological order.
