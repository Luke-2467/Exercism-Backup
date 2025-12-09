#!/usr/bin/env bash

privateKey(){
prime_1="$1"

echo $((2 + RANDOM % (prime_1-2)))

}

publicKey(){
prime_1="$1"

prime_2="$2"

private_key="$3"

public_key=$((prime_2**private_key % prime_1))

echo "$public_key"
}

secret(){
prime_1="$1"

public_key="$2"

private_key="$3"

bc <<< "$public_key ^ $private_key % $prime_1"

}

"$@"
