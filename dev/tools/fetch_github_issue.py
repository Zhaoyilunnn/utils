#!/usr/bin/env python3
"""
Script to fetch a GitHub issue and all its comments, then save them to a text file.
Usage: python fetch_github_issue.py https://github.com/owner/repo/issues/123
"""

import argparse
import json
import subprocess
from urllib.parse import urlparse


def extract_repo_and_issue_id(issue_url: str) -> tuple[str, str]:
    """Extract repository and issue ID from GitHub issue URL."""
    parsed_url = urlparse(issue_url)
    if "github.com" not in parsed_url.netloc:
        raise ValueError("Not a valid GitHub URL")

    path_parts = parsed_url.path.strip("/").split("/")
    if len(path_parts) < 4 or path_parts[-2] != "issues":
        raise ValueError("Not a valid GitHub issue URL")

    owner = path_parts[0]
    repo = path_parts[1]
    issue_id = path_parts[-1]

    return f"{owner}/{repo}", issue_id


def fetch_github_issue(repo: str, issue_id: str) -> dict:
    """Fetch issue content from GitHub API."""
    cmd = [
        "curl",
        "-s",
        "-H",
        "Accept: application/vnd.github.text+json",
        f"https://api.github.com/repos/{repo}/issues/{issue_id}",
    ]

    result = subprocess.run(cmd, capture_output=True, text=True)
    if result.returncode != 0:
        raise Exception(f"Failed to fetch issue: {result.stderr}")

    return json.loads(result.stdout)


import re

def fetch_issue_comments(comments_url: str) -> list:
    """Fetch all comments for an issue, handling pagination and rate limits."""
    import requests
    all_comments = []
    url = comments_url

    # Prepare headers
    headers = {
        "Accept": "application/vnd.github.text+json"
    }
    import os
    github_token = os.environ.get("GITHUB_TOKEN")
    if github_token:
        headers["Authorization"] = f"token {github_token}"

    while url:
        print(f"Fetching comments from URL: {url}")
        response = requests.get(url, headers=headers)
        print("----- BEGIN RESPONSE HEADERS -----")
        for k, v in response.headers.items():
            print(f"{k}: {v}")
        print("----- END RESPONSE HEADERS -----\n")

        print("----- BEGIN BODY (first 500 chars) -----")
        print(response.text[:500])
        print("----- END BODY -----\n")

        if not response.text.strip():
            print("DEBUG: Empty response body.")
            raise Exception("Empty response body when fetching comments. Possible rate limit, network error, or missing authentication.\n"
                            "If you are hitting GitHub's API rate limit, try setting a GITHUB_TOKEN environment variable.")

        try:
            comments = response.json()
        except Exception as e:
            print("DEBUG: Failed to parse JSON. Body was:\n")
            print(response.text[:500])
            raise Exception(f"Failed to parse comments JSON: {e}\nBody was:\n{response.text[:500]}")

        if isinstance(comments, dict) and comments.get("message"):
            raise Exception(f"GitHub API error: {comments.get('message')}")
        all_comments.extend(comments)

        # Pagination: check for next page in Link header
        next_url = None
        link_header = response.headers.get("Link")
        if link_header:
            import re
            links = link_header.split(",")
            for link in links:
                m = re.match(r'\s*<([^>]+)>;\s*rel="([^"]+)"', link)
                if m and m.group(2) == "next":
                    next_url = m.group(1)
                    break
        url = next_url

    return all_comments


def format_issue_with_comments(issue: dict, comments: list) -> str:
    """Format issue and comments into a readable text."""
    # Start with issue information
    output = f"ISSUE #{issue['number']}: {issue['title']}\n"
    output += f"Created by: {issue['user']['login']} on {issue['created_at']}\n"
    output += f"Status: {issue['state']}\n"
    output += f"URL: {issue['html_url']}\n\n"

    # Add labels if any
    if issue["labels"]:
        labels = ", ".join([label["name"] for label in issue["labels"]])
        output += f"Labels: {labels}\n\n"

    # Add issue body
    output += "DESCRIPTION:\n"
    output += f"{issue['body_text']}\n\n"

    # Add comments, sorted by creation date
    if comments:
        output += f"COMMENTS ({len(comments)}):\n"
        output += "=" * 50 + "\n\n"

        for i, comment in enumerate(comments, 1):
            output += f"Comment #{i} by {comment['user']['login']} on {comment['created_at']}:\n"
            output += f"{comment['body_text']}\n\n"
            output += "-" * 50 + "\n\n"

    return output


def save_to_file(content: str, repo: str, issue_id: str) -> str:
    """Save content to a file and return the filename."""
    # Create filename based on repo and issue
    repo_name = repo.replace("/", "_")
    filename = f"issue_{repo_name}_{issue_id}.txt"

    with open(filename, "w", encoding="utf-8") as f:
        f.write(content)

    return filename


def main():
    parser = argparse.ArgumentParser(
        description="Fetch a GitHub issue and its comments"
    )
    parser.add_argument("issue_url", help="URL of the GitHub issue")
    args = parser.parse_args()

    try:
        # Extract repository and issue ID from URL
        repo, issue_id = extract_repo_and_issue_id(args.issue_url)

        print(f"Fetching issue #{issue_id} from {repo}...")

        # Fetch the issue
        issue = fetch_github_issue(repo, issue_id)

        # Fetch comments
        comments = []
        if issue["comments"] > 0:
            print(f"Fetching {issue['comments']} comments...")
            comments = fetch_issue_comments(issue["comments_url"])
            # Sort comments by creation date
            comments.sort(key=lambda x: x["created_at"])

        # Format the content
        content = format_issue_with_comments(issue, comments)

        # Save to file
        filename = save_to_file(content, repo, issue_id)

        print(f"Issue and comments saved to {filename}")

    except Exception as e:
        print(f"Error: {e}")
        return 1

    return 0


if __name__ == "__main__":
    exit(main())
