#!/usr/bin/env bash
main(){
number="$1"
out=""
if (( number % 3 == 0)); then
    out="${out}Pling"
fi
if (( number % 5 == 0)); then
    out="${out}Plang"
fi
if (( number % 7 == 0)); then
    out="${out}Plong"
fi
if [[ "$out" = "" ]]; then
  out="$number"  
fi

echo "$out"
}

main "$@"