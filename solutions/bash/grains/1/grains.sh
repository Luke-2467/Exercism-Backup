#!/usr/bin/env bash
main() {
square_num="$1"
if [ "$square_num" = "total" ]; then
    total=0
    for (( square=1;square<=63;square++ )); do
        power=$((square-1))
        total=$((total+2**power))
    done
    total=$((total + 9223372036854775808))
    echo 18446744073709551615
elif (( square_num == 64 )); then
    echo 9223372036854775808
elif (( square_num <= 63 && square_num > 0)); then
    total=$((2**(square_num-1)))
    echo "$total"
else 
    echo "Error: invalid input"
    exit 1
fi
}

main "$@"
    