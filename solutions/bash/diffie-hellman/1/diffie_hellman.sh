#!/usr/bin/env bash

private_key_creation(){
prime="$1"

private_key=$(echo $((2 + $RANDOM % (prime-2))))

echo "$private_key"

}

public_key_creation(){
my_prime="$1"

other_prime="$2"

private_key="$3"

public_key=$((other_prime**private_key % my_prime))

echo "$public_key"
}

shared_key(){
my_prime="$1"

public_key="$2"

private_key="$3"

secret_key=$((public_key**private_key % my_prime))

echo "$secret_key"

}

main(){

wanted_output="$1"

if [[ "$wanted_output" = "privateKey" ]]; then
    private_key_creation "$2"
elif [[ "$wanted_output" = "publicKey" ]]; then
    public_key_creation "$2" "$3" "$4"
elif [[ "$wanted_output" = "secret" ]]; then
    shared_key "$2" "$3" "$4"
fi
}
main "$@"
