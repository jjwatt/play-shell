#!/usr/bin/env bash


sort_word() {
    if [[ -z "$1" ]]; then
	echo "ERROR: No word provided to sort_word" >&2
    fi
    echo -n "$1" | grep -o . | sort | tr -d '\n'
}

is_anagram_with_sort() {
    local word1="$1"
    local word2="$2"
    local sort1
    local sort2
    sort1="$(sort_word "$word1")"
    sort2="$(sort_word "$word2")"
    if [[ "$sort1" == "$sort2" ]]; then
	return 0
    else
	return 1
    fi
}

is_anagram_with_hash() {
    local word1="$1"
    local word2="$2"

    declare -A count1
    declare -A count2
    local i

    for (( i = 0; i < "${#word1}"; i++ )) do
	local letter="${word1:$i:1}"
	count1[$letter]=$(( "${count1[$letter]}" + 1 ))
    done
    for (( i = 0; i < "${#word2}"; i++ )) do
	local letter="${word2:$i:1}"
    	count2[$letter]=$(( "${count2[$letter]}" + 1 ))
    done
    local match=0
    for key in "${!count1[@]}"; do
	if ! [[ -v "${count2[$key]}" ]]; then
	    match=1
	    break
	fi
	if (( "${count1[$key]}" != "${count2[$key]}" )); then
	    match=1
	fi
    done
    return $match
}

main() {
    time is_anagram_with_hash "$1" "$2"
    time is_anagram_with_sort "$1" "$2"
}

main "$@"
