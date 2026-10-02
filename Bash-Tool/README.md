# Bash Log Analyzer

## Tool Name
Bash Log Analyzer

## Objective
Analyze an authorized text or log file from a Linux system and summarize common security-relevant log information.

## Features
- Accepts a log file as a command-line argument.
- Counts `INFO`, `WARNING/WARN`, `ERROR`, and `CRITICAL` entries.
- Finds the most frequently occurring IPv4 addresses.
- Displays the first five `ERROR`/`CRITICAL` lines.
- Provides `--help`/`-h` usage information.
- Handles missing, non-regular, and unreadable files.
- Uses comments and standard Linux command-line utilities.

## Requirements
- Linux
- Bash
- Standard utilities such as `grep`, `sort`, `uniq`, `head`, and `wc`

## How to Run
From the Bash-Tool directory:
```bash
chmod +x tool.sh
./tool.sh sample.log
```

Help:
```bash
./tool.sh --help
```

## Example Usage
```bash
./tool.sh sample.log
```

## Example Output
```text
======================================
          BASH LOG ANALYZER
======================================
Log file        : sample.log
Total lines     : 8

Log level counts
--------------------------------------
INFO            : 3
WARNING/WARN    : 2
ERROR           : 2
CRITICAL        : 1

Top IPv4 addresses
--------------------------------------
      4 192.168.1.10
      3 10.0.0.5
      1 203.0.113.10

Error/Critical lines (first 5)
--------------------------------------
2026-10-02 10:13:20 ERROR Failed login from 203.0.113.10
2026-10-02 10:14:03 ERROR Connection refused from 192.168.1.10
2026-10-02 10:15:11 CRITICAL Repeated authentication failures from 192.168.1.10

Analysis complete.
```

## Challenges Faced
- Log formats vary between Linux applications, so the analyzer uses simple keyword and IPv4-pattern matching.
- Some logs may contain invalid IP-like strings; this tool treats them as pattern matches rather than performing full network validation.
- Large or unusual logs can contain wording that produces false-positive matches.

## Future Improvements
- Add timestamp parsing and time-window analysis.
- Add configurable keywords and severity rules.
- Export results to CSV or JSON.
- Validate IPv4 addresses before counting them.
- Support common formats such as Apache/Nginx and authentication logs.

## Safety
Analyze only logs and systems you own or are authorized to inspect.
