#!/usr/bin/env bash
main(){
sentence=$(echo "$1" | tr "-" " " | tr -d "[:punct:]" | tr "[:lower:]" "[:upper:]")

acronym=$(echo "$sentence" | grep -oE '(^|\s|-)[A-Z]' | tr -d '\n\s\ ')

echo "$acronym"

}

main "$@"
