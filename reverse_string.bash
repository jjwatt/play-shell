
reverse_str() {
    local str="$1"
    local reverse=""
    local len="${#str}"
    local idx
    for (( idx=0; idx < len; idx++ )); do
	reverse="${str:$idx:1}$reverse"
    done
    echo "$reverse"
}

main() {
    reverse_str "hello world!"
}

main "$@"
