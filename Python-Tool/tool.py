#!/usr/bin/env python3
"""Secure password generator using Python's cryptographic random module."""

import argparse
import secrets
import string
import sys


def build_character_pool(use_upper, use_lower, use_digits, use_symbols):
    """Build and return the character pool requested by the user."""
    pool = ""
    if use_upper:
        pool += string.ascii_uppercase
    if use_lower:
        pool += string.ascii_lowercase
    if use_digits:
        pool += string.digits
    if use_symbols:
        pool += string.punctuation
    return pool


def generate_password(length, use_upper=True, use_lower=True,
                      use_digits=True, use_symbols=True):
    """Generate a password using the cryptographically secure secrets module."""
    if length < 4:
        raise ValueError("Password length must be at least 4.")

    if not any([use_upper, use_lower, use_digits, use_symbols]):
        raise ValueError("At least one character set must be selected.")

    pool = build_character_pool(
        use_upper, use_lower, use_digits, use_symbols
    )

    # Guarantee one character from every selected category.
    required_sets = []
    if use_upper:
        required_sets.append(string.ascii_uppercase)
    if use_lower:
        required_sets.append(string.ascii_lowercase)
    if use_digits:
        required_sets.append(string.digits)
    if use_symbols:
        required_sets.append(string.punctuation)

    password_chars = [secrets.choice(char_set) for char_set in required_sets]

    while len(password_chars) < length:
        password_chars.append(secrets.choice(pool))

    secrets.SystemRandom().shuffle(password_chars)
    return "".join(password_chars)


def parse_args():
    """Parse command-line arguments."""
    parser = argparse.ArgumentParser(
        description="Generate secure random passwords using Python secrets."
    )
    parser.add_argument(
        "-l", "--length", type=int, default=16,
        help="password length (default: 16)"
    )
    parser.add_argument(
        "--no-upper", action="store_true",
        help="exclude uppercase letters"
    )
    parser.add_argument(
        "--no-lower", action="store_true",
        help="exclude lowercase letters"
    )
    parser.add_argument(
        "--no-digits", action="store_true",
        help="exclude numbers"
    )
    parser.add_argument(
        "--no-symbols", action="store_true",
        help="exclude symbols"
    )
    return parser.parse_args()


def main():
    """Program entry point."""
    args = parse_args()

    try:
        password = generate_password(
            args.length,
            use_upper=not args.no_upper,
            use_lower=not args.no_lower,
            use_digits=not args.no_digits,
            use_symbols=not args.no_symbols,
        )
    except ValueError as exc:
        print(f"Error: {exc}", file=sys.stderr)
        return 1

    print("=" * 42)
    print("        PYTHON PASSWORD GENERATOR")
    print("=" * 42)
    print(f"Length      : {args.length}")
    print("Character sets: selected options")
    print(f"Password    : {password}")
    print("=" * 42)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
