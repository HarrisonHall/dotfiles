#!/usr/bin/env python3

import argparse
import subprocess

TOOLS = "~/.config/dotfiles/scripts/db/tools.toml"

parser = argparse.ArgumentParser(
    prog="find-tool",
    # description=' program does',
)
parser.add_argument("term")

args = parser.parse_args()

query = f"""
.tools
    | to_entries 
    | .[] 
    | select(
      ( .key | contains(\\"{args.term}\\") ) or 
      ( .value.description | contains(\\"{args.term}\\") ) or 
      ( .value.tags[] | contains(\\"{args.term}\\") ) 
    ) 
    | {{.key: .value}} \
"""

# cat ~/.config/dotfiles/scripts/db/tools.toml | \
#   yq -p toml -o toml "$query"

result = subprocess.run(
    # ["cat", TOOLS, "|", "yq", "-p", "toml", "-o", "toml", query],
    f'cat {TOOLS} | yq -p toml -o toml "{query}"',
    shell=True,
)

exit(result.returncode)
