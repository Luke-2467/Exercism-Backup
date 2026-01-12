#!/usr/bin/env bash

#create multiple functions to summarise certain things
#summarise the number of each card
#reverse of the above
#summarise the number of suits
#
#get dictionary from function output declare -A The_Output_Dictionary="$(Dictionary_Builder)"



summarise_card_number(){
    IFS=' ' read -r -a cards <<< "$1"
    
    declare -A card_to_numeral=( [A]="14" [J]="11" [Q]="12" [K]="13" )
    
    declare -A card_number_summary

    for card in "${cards[@]}"; do
        card_number=$(echo "$card" | tr -dc "0-9AJQK")
        if [[ ${card_to_numeral[$card_number]} != "" ]]; then
            card_number=${card_to_numeral["$card_number"]}
        fi
        card_number_summary["$card_number"]=$((card_number_summary[$card_number]+1))
    done

    echo '('
    for card in  "${!card_number_summary[@]}" ; do
        echo "[$card]=${card_number_summary[$card]}"
    done
    echo ')'
}

summarise_card_suit(){
    IFS=' ' read -r -a cards <<< "$1"

    declare -A card_suit_summary

    for card in "${cards[@]}"; do
        card_suit=$(echo "$card" | tr -d "0-9AJQK")
        card_suit_summary["$card_suit"]=$((card_suit_summary[$card_suit]+1))
    done

    echo '('
    for card in  "${!card_suit_summary[@]}" ; do
        echo "[$card]=${card_suit_summary[$card]}"
    done
    echo ')'
}

straight_check(){
    declare -a card_numbers=( "$@" )
    
    if [[ "${#card_numbers[@]}" != 5 ]]; then
        echo 0
        exit 0
    fi
    
    IFS=$'\n' card_numbers_sorted=($(sort -n <<<"${card_numbers[*]}"))
    unset IFS
    
    lowest_card="${card_numbers_sorted[0]}"
    highest_card="${card_numbers_sorted[4]}"
    low_ace=0
    #control for ace being able to take values of 14 and 1
    if (( lowest_card == 2 && highest_card == 14 )); then
        card_numbers_sorted[4]=1
         #resort
        IFS=$'\n' card_numbers_sorted=($(sort -n <<<"${card_numbers_sorted[*]}"))
    unset IFS
    low_ace=1
    fi

    for ((index=0;index<4;index++)); do
        if ((card_numbers_sorted[index+1]-card_numbers_sorted[index] != 1)); then
            echo 0
            exit 0
        fi
    done
    echo "1" "$low_ace"
}

rank_hand(){
    hand="$1"
    declare -A hand_suit_summary=$(summarise_card_suit "$hand")
    declare -A hand_number_summary=$(summarise_card_number "$hand")
    
    #sort hand suits and hand number
    IFS=$'\n' matching_numbers_sorted=($(sort -r -n <<<"${hand_number_summary[*]}"))
    card_numbers_sorted=($(sort -r -n <<<"${!hand_number_summary[*]}"))
    unset IFS

    straight_result=( $(straight_check "${!hand_number_summary[@]}") )
    
    straight_indicator="${straight_result[0]}"

    rank=0

    #straight flush
    if [[ "$straight_indicator" = 1 && "${hand_suit_summary[*]}" = "5" ]]; then
        rank=1
    #four of a kind
    elif [[ "${matching_numbers_sorted[0]}" = "4" ]]; then
        rank=2
    #full house
    elif [[ "${matching_numbers_sorted[*]}" = "3 2" ]]; then
        rank=3
    #flush
    elif [[ "${hand_suit_summary[*]}" = "5" ]]; then
        rank=4
    #straight
    elif [[ "$straight_indicator" = "1" ]]; then
        rank=5
    #trips
    elif [[ "${matching_numbers_sorted[0]}" = "3" ]]; then
        rank=6
    #two pair
    elif [[ "${matching_numbers_sorted[*]}" = "2 2 1" ]]; then
        rank=7
    #pair
    elif [[ "${matching_numbers_sorted[0]}" = "2" ]]; then
        rank=8
    #high card
    else 
        rank=9
    fi
    echo "$rank"
}

compare_high_cards(){
IFS=' ' read -r -a kickers_1 <<< "$1"
IFS=' ' read -r -a kickers_2 <<< "$2"

IFS=$'\n' kickers_1=($(sort -r -n <<<"${kickers_1[*]}"))
kickers_2=($(sort -r -n <<<"${kickers_2[*]}"))
unset IFS
numer_of_kickers="${#kickers_1[@]}"

for ((index=0;index<numer_of_kickers;index++)); do

    if (( kickers_1[index] > kickers_2[index] )); then
        echo "1"
        exit 0
    elif (( kickers_1[index] < kickers_2[index] )); then
        echo "2"
        exit 0
    fi
done

echo "0"
}

compare_same_type_of_hand(){
rank="$1"
hand_1="$2"
hand_2="$3"

declare -A hand_1_number_summary=$(summarise_card_number "$hand_1")
declare -A hand_2_number_summary=$(summarise_card_number "$hand_2")

winner="0"
kickers_1=()
kickers_2=()

straight_1_result=( $(straight_check "${!hand_1_number_summary[@]}") )
    
    low_ace_1_indicator="${straight_1_result[1]}"

    straight_2_result=( $(straight_check "${!hand_2_number_summary[@]}") )
    
    low_ace_2_indicator="${straight_2_result[1]}"
    
    if (( low_ace_1_indicator == 1 )); then 
        unset "hand_1_number_summary[14]"
        hand_1_number_summary["1"]="1"
    fi
    
    if (( low_ace_2_indicator == 1 )); then 
        unset "hand_2_number_summary[14]"
        hand_2_number_summary["1"]="1"
    fi


if [[ "$rank" = "1" || "$rank" = "4" || "$rank" = "5" ]]; then
    kickers_1=( "${!hand_1_number_summary[@]}" )
    kickers_2=( "${!hand_2_number_summary[@]}" )

elif [[ "$rank" = "2" ]]; then

    for card in "${!hand_1_number_summary[@]}"; do
        if [[ "${hand_1_number_summary[$card]}" = "4" ]]; then
            hand_1_quad="$card"
        else
            kickers_1+=("$card")
        fi
    done
    for card in "${!hand_2_number_summary[@]}"; do
        if [[ "${hand_2_number_summary[$card]}" = "4" ]]; then
            hand_2_quad="$card"
        else
            kickers_2+=("$card")
        fi
    done

    if (( hand_2_quad > hand_1_quad )); then
        winner="2"
    elif (( hand_2_quad < hand_1_quad )); then
        winner="1"
    fi
    
elif [[ "$rank" = "3" ]]; then
    for card in "${!hand_1_number_summary[@]}"; do
        if [[ "${hand_1_number_summary[$card]}" = "3" ]]; then
            hand_1_trip="$card"
        elif [[ "${hand_1_number_summary[$card]}" = "2" ]]; then
            hand_1_pair="$card"
        fi
    done

    for card in "${!hand_2_number_summary[@]}"; do
        if [[ "${hand_2_number_summary[$card]}" = "3" ]]; then
            hand_2_trip="$card"
        elif [[ "${hand_2_number_summary[$card]}" = "2" ]]; then
            hand_2_pair="$card"
        fi
    done

    if (( hand_2_trip > hand_1_trip )); then
        winner="2"
    elif (( hand_2_trip < hand_1_trip )); then
        winner="1"
    elif (( hand_2_pair > hand_1_pair )); then
        winner="2"
    elif (( hand_2_pair < hand_1_pair )); then
        winner="1"
    fi
elif [[ "$rank" = "6" ]]; then
    for card in "${!hand_1_number_summary[@]}"; do
        if [[ "${hand_1_number_summary[$card]}" = "3" ]]; then
            hand_1_trip="$card"
        else 
            kickers_1+=( "$card" )
        fi
    done
    for card in "${!hand_2_number_summary[@]}"; do
        if [[ "${hand_2_number_summary[$card]}" = "3" ]]; then
            hand_2_trip="$card"
        else 
            kickers_2+=( "$card" )
        fi
    done

    if (( hand_2_trip > hand_1_trip )); then
        winner="2"
    elif (( hand_2_trip < hand_1_trip )); then
        winner="1"
    fi
elif [[ "$rank" = "7" ]]; then
     hand_1_pairs=()
    for card in "${!hand_1_number_summary[@]}"; do
        if [[ "${hand_1_number_summary[$card]}" = "2" ]]; then
            hand_1_pairs+=("$card")
        else 
            kickers_1+=( "$card" )
        fi
    done
    hand_2_pairs=()
    for card in "${!hand_2_number_summary[@]}"; do
        if [[ "${hand_2_number_summary[$card]}" = "2" ]]; then
            hand_2_pairs+=("$card")
        else 
            kickers_2+=( "$card" )
        fi
    done

    IFS=$'\n' hand_1_pairs=($(sort -r -n <<<"${hand_1_pairs[*]}"))
    hand_2_pairs=($(sort -r -n <<<"${hand_2_pairs[*]}"))
    unset IFS   

    for ((card_index=0;card_index<2;card_index++)); do
        hand_1_pair="${hand_1_pairs[$card_index]}"
        hand_2_pair="${hand_2_pairs[$card_index]}"
        
        if (( hand_2_pair > hand_1_pair )); then
            winner="2"
            break
        elif (( hand_2_pair < hand_1_pair )); then
            winner="1"
            break
        fi
    done
elif [[ "$rank" = "8" ]]; then
    for card in "${!hand_1_number_summary[@]}"; do
        if [[ "${hand_1_number_summary[$card]}" = "2" ]]; then
            hand_1_pair="$card"
        else 
            kickers_1+=( "$card" )
        fi
    done
    for card in "${!hand_2_number_summary[@]}"; do
        if [[ "${hand_2_number_summary[$card]}" = "2" ]]; then
            hand_2_pair="$card"
        else 
            kickers_2+=( "$card" )
        fi
    done

    if (( hand_2_pair > hand_1_pair )); then
        winner="2"
    elif (( hand_2_pair < hand_1_pair )); then
        winner="1"
    fi
elif [[ "$rank" = "9" ]]; then
    kickers_1=("${!hand_1_number_summary[@]}")
    kickers_2=("${!hand_2_number_summary[@]}")
fi

if [[ "$winner" = "0" ]]; then
    winner=$(compare_high_cards "${kickers_1[*]}" "${kickers_2[*]}")
fi

echo "$winner"
}

compare_hands(){
hand_1="$1"
hand_2="$2"

hand_1_rank=$(rank_hand "$hand_1")
hand_2_rank=$(rank_hand "$hand_2")

if (( hand_1_rank < hand_2_rank )); then
    echo 1
elif (( hand_1_rank > hand_2_rank )); then
    echo 2
elif (( hand_1_rank == hand_2_rank )); then
    compare_same_type_of_hand "$hand_1_rank" "$hand_1" "$hand_2"
fi

}

main(){

current_winning_hand="$1"
shift
hands=( "$@" )

for hand in "${hands[@]}"; do
    winning_hand=$(compare_hands "$current_winning_hand" "$hand")

    if [[ "$winning_hand" = "2" ]]; then
        winning_hands=()
        current_winning_hand="$hand"
    elif [[ "$winning_hand" = "0" ]]; then
        winning_hands+=("$hand")
    fi
done

echo "$current_winning_hand"
for hand in "${winning_hands[@]}"; do
    echo "$hand"
done

}

main "$@"

