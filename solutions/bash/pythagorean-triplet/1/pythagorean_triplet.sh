#!/usr/bin/env bash

main(){

max_sum="$1"

for ((smallest_num=1;smallest_num<=max_sum-3;smallest_num++)); do
    for ((second_num=smallest_num+1;second_num<max_sum-smallest_num;second_num++)); do
        third_num=$((max_sum-second_num-smallest_num))
        if (( smallest_num**2+second_num**2 == third_num**2 )); then
            echo "$smallest_num,$second_num,$third_num"
        fi
    done
done

}

main "$@"
