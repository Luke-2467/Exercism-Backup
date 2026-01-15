debug(){
    echo "last action $last_action"
    echo "goal bucket ${bucket[1]} ${limits[1]}"
    echo "other bucket ${bucket[2]} ${limits[2]}"
    echo "target $target"
}

transfer() {
    if (( bucket[starting_bucket]+bucket[other_bucket] <= limits[other_bucket] )); then
        bucket[other_bucket]=$((bucket[other_bucket]+bucket[starting_bucket]))
        bucket[starting_bucket]=0
    else
        bucket[starting_bucket]=$((bucket[starting_bucket]-limits[other_bucket]+bucket[other_bucket]))
        bucket[other_bucket]=$(( limits[other_bucket] ))
    fi
}

check_win(){
if (( bucket[1] == target )); then
    echo "moves: $moves, goalBucket: one, otherBucket: ${bucket[2]}"
    exit 0
elif (( bucket[2] == target )); then
    echo "moves: $moves, goalBucket: two, otherBucket: ${bucket[1]}"
    exit 0
fi
}

check_fail(){
if [[ "${found_configurations[${bucket[*]}]}" = "1" ]]; then
    echo "invalid goal"
    exit 1
else
    found_configurations["${bucket[*]}"]="1"
fi

if (( bucket[starting_bucket] == 0 && bucket[other_bucket] == limits[other_bucket] )); then
    echo "invalid goal"
    exit 1
fi


}
main(){
read -a inputs <<< "$@"

starting_bucket="${inputs[3]}"

if [[ "$starting_bucket" = "one" ]]; then
    starting_bucket=1
    other_bucket=2
else
    starting_bucket=2
    other_bucket=1
fi

declare -a bucket limits

limits[1]="${inputs[0]}"
limits[2]="${inputs[1]}"

if (( target > limits[1] && target > limits[2] )); then
    echo "invalid goal"
    exit 1
fi

bucket[starting_bucket]=$((limits[starting_bucket]))

bucket[other_bucket]=0

target="${inputs[2]}"

moves=1

if (( limits[other_bucket] == target )); then
    bucket[other_bucket]="${limits[other_bucket]}"
    moves=2
    check_win
fi

declare -A found_configurations

while (( moves<100 )) ; do
    check_win
    
    moves=$((moves+1))
    
    if (( bucket[starting_bucket] == 0 )); then
        bucket[starting_bucket]="${limits[starting_bucket]}"
        last_action="fill starting bucket"
    elif (( bucket[other_bucket] == limits[other_bucket] )); then
        bucket[other_bucket]=0
        last_action="empty other bucket"
    else
    
    last_action="transfer"
        transfer
    fi

    check_fail
    #debug
done

}

main "$@"