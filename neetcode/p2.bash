#!/usr/bin/env bash


sort_word() {
    if [[ -z "$1" ]]; then
	echo "ERROR: No word provided to sort_word" >&2
    fi
    echo -n "$1" | grep -o . | sort | tr -d '\n'
}

is_anagram() {
    local word1="$1"
    local word2="$2"
    local sort1
    local sort2
    sort1="$(sort_word "$word1")"
    sort2="$(sort_word "$word2")"
    if [[ "$sort1" == "$sort2" ]]; then
	echo "$word2 is a valid anagram of $word1"
	return 0
    else
	echo "$word2 is not a valid anagram of $word1"
	return 1
    fi
}

main() {
    is_anagram "$1" "$2"
}

main "$@"
