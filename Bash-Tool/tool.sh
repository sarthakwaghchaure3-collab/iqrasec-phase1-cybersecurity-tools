#!/usr/bin/env bash
# Bash Log Analyzer
# Analyzes a text/log file for common log levels, IP addresses, and error lines.

set -u

show_help() {
    cat <<'EOF'
Usage:
  ./tool.sh <log_file>
  ./tool.sh --help

Description:
  Analyze a log/text file and display:
  - Total number of lines
  - INFO/WARNING/ERROR/CRITICAL counts
  - Top IPv4 addresses found
  - First few error/critical lines

Examples:
  ./tool.sh sample.log
  ./tool.sh --help
EOF
}

if [[ "${1:-}" == "--help" || "${1:-}" == "-h" ]]; then
    show_help
    exit 0
fi

if [[ $# -ne 1 ]]; then
    echo "Error: exactly one log file is required." >&2
    show_help >&2
    exit 2
fi

LOG_FILE="$1"

if [[ ! -e "$LOG_FILE" ]]; then
    echo "Error: file '$LOG_FILE' does not exist." >&2
    exit 1
fi

if [[ ! -f "$LOG_FILE" ]]; then
    echo "Error: '$LOG_FILE' is not a regular file." >&2
    exit 1
fi

if [[ ! -r "$LOG_FILE" ]]; then
    echo "Error: file '$LOG_FILE' is not readable." >&2
    exit 1
fi

total_lines=$(wc -l < "$LOG_FILE")
info_count=$(grep -Eic '\bINFO\b' "$LOG_FILE" || true)
warning_count=$(grep -Eic '\b(WARN|WARNING)\b' "$LOG_FILE" || true)
error_count=$(grep -Eic '\bERROR\b' "$LOG_FILE" || true)
critical_count=$(grep -Eic '\bCRITICAL\b' "$LOG_FILE" || true)

echo "======================================"
echo "          BASH LOG ANALYZER"
echo "======================================"
echo "Log file        : $LOG_FILE"
echo "Total lines     : $total_lines"
echo
echo "Log level counts"
echo "--------------------------------------"
printf "INFO            : %s\n" "$info_count"
printf "WARNING/WARN    : %s\n" "$warning_count"
printf "ERROR           : %s\n" "$error_count"
printf "CRITICAL        : %s\n" "$critical_count"

echo
echo "Top IPv4 addresses"
echo "--------------------------------------"
ip_count=$(grep -Eo '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b' "$LOG_FILE" 2>/dev/null \
    | sort \
    | uniq -c \
    | sort -nr \
    | head -5 || true)

if [[ -n "$ip_count" ]]; then
    printf '%s\n' "$ip_count"
else
    echo "No IPv4 addresses found."
fi

echo
echo "Error/Critical lines (first 5)"
echo "--------------------------------------"
error_lines=$(grep -Ei '\b(ERROR|CRITICAL)\b' "$LOG_FILE" 2>/dev/null | head -5 || true)

if [[ -n "$error_lines" ]]; then
    printf '%s\n' "$error_lines"
else
    echo "No error or critical lines found."
fi

echo
echo "Analysis complete."
