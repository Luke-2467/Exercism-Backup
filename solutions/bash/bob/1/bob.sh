#!/usr/bin/env bash

main(){
message="$1"

if [[ "$message" =~ ^[[:space:]]+$ || "$message" == '' ]]; then
    echo "Fine. Be that way!"
elif [[ "$message" =~ ^[^a-z]*\?*[[:space:]]+$ || "$message" =~ ^[^a-z]*\?+$ && "$message" =~ [A-Z] ]]; then
    echo "Calm down, I know what I'm doing!"
elif [[ "$message" =~ ^[^a-z]*$ && "$message" =~ [A-Z] ]]; then
    echo "Whoa, chill out!"
elif [[ "$message" =~ .*\?+$ || "$message" =~ ^.*\?+[[:space:]]+$ ]]; then
    echo "Sure."
else 
    echo "Whatever."
fi
}
main "$@"
