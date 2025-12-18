#!/usr/bin/env bash

main(){
strike_indicator_1=0

strike_indicator_2=0

spare_indicator=0

bowls_in_frame=0

frame_score=0

number_of_frames=0

bowls=("$@")

extra_bowls=0

frame_limit=10

number_of_pins=10

score=0

for bowl in "${bowls[@]}"; do
    
    if (( bowl < 0 )); then
        echo "Negative roll is invalid"
        exit 1
    fi
    
    bowls_in_frame=$((bowls_in_frame+1))
    
    frame_score=$((frame_score+bowl))

    if (( extra_bowls == 2 )); then
        score=$(( score + bowl + bowl*strike_indicator_1 ))
    elif (( extra_bowls == 1 )); then
        score=$(( score + bowl ))
    else
        score=$(( score + bowl + bowl*spare_indicator + bowl*strike_indicator_2 + bowl*strike_indicator_1 ))
    fi
    
    if ((frame_score>number_of_pins)); then
        echo "Pin count exceeds pins on the lane"
        exit 1
    fi

    if (( spare_indicator == 1 )); then
        spare_indicator=0
    fi
    
    if (( strike_indicator_1 == 1 )); then
        strike_indicator_1=0
    fi
    
    if (( strike_indicator_2 == 1 )); then
        strike_indicator_1=1
        strike_indicator_2=0
    fi

    if (( frame_score == number_of_pins && bowls_in_frame == 2 )); then
        spare_indicator=1
    fi
    
    if (( bowl == number_of_pins && bowls_in_frame == 1 )); then
        strike_indicator_2=1 
    fi
    
    if ((bowls_in_frame == 2 || bowl == number_of_pins)); then
        frame_score=0
        number_of_frames=$((number_of_frames+1))
        bowls_in_frame=0
    fi

    if (( number_of_frames == frame_limit && strike_indicator_2 == 1 )); then
        extra_bowls=2
    elif (( number_of_frames == frame_limit && spare_indicator == 1 )); then
        extra_bowls=1
    elif (( number_of_frames > frame_limit)); then
        extra_bowls=$((extra_bowls-1))
    fi

    if (( number_of_frames == frame_limit )); then
        number_of_frames=$((number_of_frames+1))
    fi
    
    if (( extra_bowls < 0 )); then
        echo "Cannot roll after game is over"
        exit 1
    fi

done

if (( extra_bowls > 0 || number_of_frames < frame_limit )); then
    echo "Score cannot be taken until the end of the game"
    exit 1
fi

echo "$score"
}

main "$@"