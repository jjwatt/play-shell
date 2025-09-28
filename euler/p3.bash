#!/usr/bin/env bash

n=600851475143
largest=1

# Handle factor 2.
while (( n % 2 == 0 )); do
    largest=2
    n=$(( n / 2))
done

# Check the factors from 3 upwards.
i=3
while (( i * i <= n )); do
    while (( n % i == 0 )); do
	largest="$i"
	n=$(( n / i ))
    done
    i=$(( i + 2 ))
done

if (( n > 1 )); then
    largest="$n"
fi

echo "$largest"
