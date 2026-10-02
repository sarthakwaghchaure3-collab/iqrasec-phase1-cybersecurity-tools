# Python Password Generator

## Tool Name
Python Password Generator

## Objective
Generate strong random passwords for authorized personal or development use.

## Features
- Uses Python's `secrets` module for cryptographically secure random choices.
- Supports configurable password length.
- Supports uppercase letters, lowercase letters, digits, and symbols.
- Guarantees at least one character from every selected category.
- Uses functions and command-line arguments.
- Includes `--help` usage information.
- Handles invalid length and empty character-set selections.

## Requirements
- Python 3.8+
- Python standard library only
- No third-party packages required

## How to Run
From the Python-Tool directory:
```bash
python3 tool.py --length 16
```

Help:
```bash
python3 tool.py --help
```

Examples:
```bash
python3 tool.py --length 20
python3 tool.py --length 12 --no-symbols
```

## Example Usage
```bash
python3 tool.py --length 16
```

## Example Output
```text
==========================================
        PYTHON PASSWORD GENERATOR
==========================================
Length      : 16
Character sets: selected options
Password    : <randomly generated value>
==========================================
```

Each execution generates a new password. Do not reuse or publicly post a real password.

## Challenges Faced
- A password generator should use a cryptographically suitable source of randomness.
- Different users may require different character sets and password lengths.
- Very short passwords reduce security, so the tool enforces a minimum length of 4.

## Future Improvements
- Add passphrase generation.
- Add an optional password-strength estimate.
- Add secure clipboard integration where supported.
- Add a non-interactive JSON output mode for automation.

## Safety
Generated passwords should be treated as sensitive information. Do not commit real passwords or API secrets to GitHub.
