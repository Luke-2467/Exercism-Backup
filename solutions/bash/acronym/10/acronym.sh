#!/usr/bin/env bash
echo "$1" | tr "-" " " | tr -d "[:punct:]" | tr "[:lower:]" "[:upper:]" | grep -oE '(^|\s|-)[A-Z]' | tr -d '\n\s\ '