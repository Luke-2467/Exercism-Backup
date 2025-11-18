#!/usr/bin/env bash
error_message(){
    echo "Usage: leap.sh <year>"
    exit 1
}

main(){
#check only one argument
if (( "$#" != 1 )); then
    error_message
fi
year="$1"
case "$year" in 
        ''|*[!0-9]*) 
        error_message
        ;;
esac

if (( year % 4 == 0 && year % 100 != 0 )); then
    echo true
elif (( year % 400 == 0 )); then
    echo true
else 
    echo false
fi
}

main "$@"