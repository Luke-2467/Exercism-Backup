#!/usr/bin/env bash
other_person="$1"

if [[ "$other_person" == "" ]]; then
    other_person="you"
fi

echo "One for $other_person, one for me."