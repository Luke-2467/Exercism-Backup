#want to build up to target amount of change with the number of coins we have. I.e. 
#to get the minimum number of coins to get to say change of 9 given coins [1 2 5] then we do the following,

#the minimum number of coins for change of 1 is of course 1. Next, we check how many to get to a change of two.
#we know it takes 1 coin to get to one so we start from there, adding another 1 coin gives us 2 coins. However, then checking our next coin two, we see that this is now our minimum amount and we are done.

main(){

change_required="$1"
if (( change_required < 0 )); then
    echo "target can't be negative"
    exit 1
fi

shift

coins=("$@")

number_of_coins=${#coins[@]}
min_coin_value="${coins[0]}"

declare -A min_coins_for_change=( ["0"]=0 ["$min_coin_value"]=1 )

declare -A coins_used_for_change=( ["$min_coin_value"]="$min_coin_value" )

for ((change_amount=min_coin_value+1;change_amount<=change_required;change_amount++)); do
#initiate empty cells for our results arrays
current_min=1000
coins_for_current_min=()
#echo "change amount: $change_amount"
    for (( coin_index=0; coin_index< number_of_coins; coin_index++)); do
        coin=${coins[$coin_index]}
        #cho "Coin: $coin"
        
        change_after_coin=$((change_amount-coin))

        min_coins_after_current_coin="${min_coins_for_change[$change_after_coin]}"

        if [[ "$min_coins_after_current_coin" = "" ]]; then
            continue
        fi
        
        #echo "Change after coin: $change_after_coin"
        #echo "number of coins now: $((1+min_coins_after_current_coin))"
        #echo "current min: $current_min"
        
        if ((change_after_coin<0)); then       
            break
        fi
        
        if (( 1+min_coins_after_current_coin < current_min )); then
            current_min=$((1+min_coins_after_current_coin))
            
            coins_for_current_min=( "$coin" "${coins_used_for_change[$change_after_coin]}" )
        fi
        #echo "coins used for change: ${coins_for_current_min[@]}"
    done
    min_coins_for_change["$change_amount"]=$current_min
    coins_used_for_change["$change_amount"]="${coins_for_current_min[@]}"    
done

result="$(echo "${coins_used_for_change["$change_required"]}" | xargs)"

if [[ "$result" = "" && "$change_required" != "0" ]]; then
    echo "can't make target with given coins"
    exit 1
fi

echo "$result"
}

main "$@"

        
    
