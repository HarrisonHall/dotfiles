#!/usr/bin/env python3

import argparse

LOWERCASE: str = "abcdefghijklmnopqrstuvwxyz"
UPPERCASE: str = LOWERCASE.upper()
NUMBERS: str = "0123456789"


def parse_args() -> dict:
    parser = argparse.ArgumentParser(
        prog="rot13",
        description="rotX util",
    )
    parser.add_argument(
        "value",
        type=str,
    )
    parser.add_argument(
        "-r",
        "--rotation",
        type=int,
        default=13,
        dest="x",
    )
    parser.add_argument(
        "--half",
        action="store_true",
    )

    args = parser.parse_args()
    return vars(args)


def rot_char_x(char: str, charset: str, x: int | None) -> str:
    if x is None:
        x = len(charset) // 2
    if char not in charset:
        return char
    return charset[(charset.find(char) + x) % len(charset)]


def rot_x(value: str, x: int | None, **_kwargs) -> str:
    rotted: str = ""
    for char in value.lower():
        if char in LOWERCASE:
            rotted += rot_char_x(char, LOWERCASE, x)
            continue
        if char in UPPERCASE:
            rotted += rot_char_x(char, UPPERCASE, x)
            continue
        if char in NUMBERS:
            rotted += rot_char_x(char, NUMBERS, x)
            continue
        rotted += char
    return rotted


if __name__ == "__main__":
    args = parse_args()
    if args.get("half", False):
        args["x"] = None

    rotted = rot_x(**args)

    print(rotted)

    exit(0)
