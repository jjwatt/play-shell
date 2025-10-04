
reverse_str() {
    local str="$1"
    local reverse=""
    local i
    for (( i=0; i < "${#str}"; i++ )); do
	reverse="${str:$i:1}$reverse"
    done
    echo "$reverse"
}

is_palindrome() {
    local str="$1"
    if [[ -z "$str" ]]; then
	echo "${FUNCNAME[0]} requires 1 argument." >&2
    fi
    local rev_str
    rev_str="$(reverse_str "$str")"
    if [[ "$str" == "$rev_str" ]]; then
	echo "$str is a palindrome."
	return 0
    else
	echo "$str is not a palindrome."
	return 1
    fi
}
