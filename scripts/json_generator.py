#!/usr/bin/env python3

import sys
import requests
import json
from urllib.parse import urlparse

def main():
    # Grab the GitHub URL from command-line args
    github_url = "https://github.com/notfadil/azureetlproject/tree/main"
    # Optional output file name
    output_filename = "git.json"

    # Parse owner, repo, branch, and folder path (no validation)
    path_parts = [p for p in urlparse(github_url).path.split('/') if p]
    owner = path_parts[0]
    repo = path_parts[1]
    branch = path_parts[3]
    folder_path = "/".join(path_parts[4:])

    # Build the GitHub Contents API URL (no error checks)
    contents_url = f"https://api.github.com/repos/{owner}/{repo}/contents/{folder_path}?ref={branch}"

    # Fetch JSON from GitHub (assumes success)
    response = requests.get(contents_url)
    files = response.json()

    # Build output JSON array
    output_list = []
    prefix = "AdventureWorks_"
    suffix = ".csv"

    for f in files:
        file_name = f["name"]
        # Filter by "AdventureWorks_*.csv"
        if file_name.startswith(prefix) and file_name.endswith(suffix):
            after_prefix = file_name[len(prefix):]   # e.g. "Calendar.csv"
            folder_name = after_prefix.replace(suffix, "")  # e.g. "Calendar"
            p_rel_url = f"{owner}/{repo}/refs/heads/{branch}/{file_name}"

            output_list.append({
                "p_rel_url": p_rel_url,
                "p_sink_folder": folder_name,
                "p_sink_file": after_prefix
            })

    # Write the JSON to file in current directory
    with open(output_filename, "w", encoding="utf-8") as f:
        json.dump(output_list, f, indent=2)

if __name__ == "__main__":
    main()
