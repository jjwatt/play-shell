
## @fn get_version_parts()
## @brief Build an aray of major, minor, patch
## @param version_string
get_version_parts() {
    local version_string="$1"
    IFS="." read -ra parts <<< "$version_string"
    printf "%s\n" "${parts[@]}"
}

## @fn compare_versions()
## @brief Compare first version and second version number
## @details Roughly follows C's cmp convention. If the first version
## is greater than the second version return 1. If the first version
## is less than the second version, return 2. If they'r equal,
## return 0. Only handles 3 values. Pass 0s if you're using 2 value
## version numbers.
## @param first_version The first version to compare.
## @param second_version The second version to compare.
## @return 0 if equal, 1 if first > second, 2 if first < second.
compare_versions() {
    local first_version="$1"
    local second_version="$2"
    local first_version_arr=($(get_version_parts "$first_version"))
    local second_version_arr=($(get_version_parts "$second_version"))
    local first_major="${first_version_arr[0]}"
    local first_minor="${first_version_arr[1]}"
    local first_patch="${first_version_arr[2]}"
    local second_major="${second_version_arr[0]}"
    local second_minor="${second_version_arr[1]}"
    local second_patch="${second_version_arr[2]}"

    if ((first_major < second_major )); then
	return 2
    elif ((first_major > second_major)); then
	return 1
    elif ((first_major == second_major)); then
	if ((first_minor < second_minor)); then
	    return 2
	elif ((first_minor > second_minor)); then
	    return 1
	elif ((first_minor == second_minor)); then
	    if ((first_patch < second_patch)); then
		return 2
	    elif ((first_patch > second_patch)); then
		return 1
	    elif ((first_patch == second_patch)); then
	        return 0
	    fi
	fi
    fi
}
