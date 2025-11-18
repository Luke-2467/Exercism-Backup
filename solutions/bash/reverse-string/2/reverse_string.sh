#!/usr/bin/env bash

main (){
    string="$1"
    string_length="${#string}"
    if (( $string_length==0 )); then
    echo "$rev"
    else 
    for((char_num=$string_length-1;char_num>=0;char_num--));
    do rev="$rev${string:char_num:1}"; 
    done
    echo "$rev"
    fi
}
main "$@"

