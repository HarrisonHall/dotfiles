#!/usr/bin/env python3

import argparse


def parse_args() -> dict:
    parser = argparse.ArgumentParser(
        prog="rot13",
        description="rotX util",
    )
    parser.add_argument(
        "value",
        type=str,
        # dest="value",
    )
    parser.add_argument(
        "-r",
        "--rotation",
        type=int,
        default=13,
        dest="x",
    )

    args = parser.parse_args()
    return vars(args)


def rotX(value: str, x: int) -> str:
    letters: str = "abcdefghijklmnopqrstuvwxyz"
    rotted: str = ""
    for char in value.lower():
        if char not in letters:
            rotted += char
            continue
        rotted += letters[(letters.find(char) + x) % len(letters)]
    return rotted


if __name__ == "__main__":
    rotted = rotX(**parse_args())
    print(rotted)
    exit(0)
