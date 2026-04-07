#!/usr/bin/env python3

import argparse
import subprocess

TOOLS = "~/.config/dotfiles/scripts/db/tools.toml"


def parse_args() -> dict:
    parser = argparse.ArgumentParser(
        prog="find-tool",
        description="Find a tool in tools.toml database.",
    )
    parser.add_argument("term", nargs="?", default="")
    parser.add_argument("--edit", action="store_true")

    args = parser.parse_args()
    return vars(args)


def find_tool(term: str, edit: bool = False, *args, **kwargs):
    if edit:
        result = subprocess.run(f"$EDITOR {TOOLS}", shell=True)
        return result.returncode

    if not len(term):
        _result = subprocess.run(f"bat {TOOLS}", shell=True)
        return 0

    query = f"""
    .tools
        | to_entries 
        | .[] 
        | select(
          ( .key | contains(\\"{term}\\") ) or 
          ( .value.description | contains(\\"{term}\\") ) or 
          ( .value.tags[] | contains(\\"{term}\\") ) 
        ) 
        | {{.key: .value}} \
    """

    result = subprocess.run(
        # ["cat", TOOLS, "|", "yq", "-p", "toml", "-o", "toml", query],
        f'cat {TOOLS} | yq -p toml -o toml "{query}"',
        shell=True,
    )

    return result.returncode


if __name__ == "__main__":
    exit(find_tool(**parse_args()))
