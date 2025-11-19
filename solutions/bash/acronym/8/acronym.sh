#!/usr/bin/env bash
main(){
echo "$1" | tr "-" " " | tr -d "[:punct:]" | tr "[:lower:]" "[:upper:]" | grep -oE '(^|\s|-)[A-Z]' | tr -d '\n\s\ '

}

main "$@"
