#!/usr/bin/env bash

max_palindrome=0

# Iterate from 999 down to 100 for both factors.
for (( i = 999; i >= 100; i-- )); do
    for (( j = 999; j >= i; j-- )); do
	product=$(( i * j ))

	str="$product"
	reverse=""
	len="${#str}"

	for (( idx=0; idx < len; idx++ )); do
	    reverse="${str:$idx:1}$reverse"
	done

	if [[ $str = $reverse ]] \
	       && (( product > max_palindrome )); then
	    max_palindrome="$product"
	    factor1="$i"
	    factor2="$j"
	fi
    done
done

echo "Largest palindrome number: $max_palindrome"
echo "Made from $factor1 x $factor2"
