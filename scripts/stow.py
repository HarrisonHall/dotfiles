#!/usr/bin/env python3

import argparse
import subprocess
from pathlib import Path


def parse_args() -> dict:
    parser = argparse.ArgumentParser(
        prog="stow",
        description="Simple symlink farming",
    )
    parser.add_argument("from_directory", type=Path)
    parser.add_argument("to_directory", type=Path)

    args = parser.parse_args()
    return vars(args)


def symlink(from_doc: Path, to_doc: Path) -> bool:
    if to_doc.exists():
        if to_doc.is_symlink():
            return True
        if not to_doc.is_symlink():
            raise Exception(f"{to_doc} already exists.")

    command = "ln -sni {from_doc} {to_doc}".format(
        from_doc=str(from_doc.absolute()),
        to_doc=str(to_doc.absolute()),
    )

    result = subprocess.run(
        command,
        shell=True,
    )

    return result.returncode == 0


def symlink_all(from_directory: Path, to_directory: Path, **kwargs) -> int:
    if not from_directory.is_dir():
        raise Exception(f"{from_directory} is not a directory.")
    if not to_directory.exists():
        to_directory.mkdir(parents=True, exists_ok=False)
    if not to_directory.is_dir():
        raise Exception(f"{to_directory} is not a directory.")

    succ: bool = True
    for from_file in from_directory.iterdir():
        try:
            succ &= symlink(from_file, to_directory / from_file.name)
        except Exception as e:
            print("Error: ", e)
            succ = False

    return 0 if succ else 1


if __name__ == "__main__":
    exit(symlink_all(**parse_args()))
