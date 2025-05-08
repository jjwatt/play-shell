
## @fn get_version_parts()
## @brief Build an aray of major, minor, patch
## @param version_string
get_version_parts() {
    local version_string="$1"
    IFS="." read -ra parts <<< "$version_string"
    printf "%s\n" "${parts[@]}"
}

compare_versions() {
    local current_version="$1"
    local wanted_version="$2"
    local current_version_arr=($(get_version_parts "$current_version"))
    local wanted_version_arr=($(get_version_parts "$wanted_version"))
    local current_major="${current_version_arr[0]}"
    local current_minor="${current_version_arr[1]}"
    local current_patch="${current_version_arr[2]}"
    local wanted_major="${wanted_version_arr[0]}"
    local wanted_minor="${wanted_version_arr[1]}"
    local wanted_patch="${wanted_version_arr[2]}"

    if ((current_major < wanted_major )); then
	echo return 1
    elif ((current_major > wanted_major)); then
	echo "unsupported"
    elif ((current_major == wanted_major)); then
	if ((current_minor < wanted_minor)); then
	    echo "normalupgrade"
	elif ((current_minor > wanted_minor)); then
	    echo "unsupported"
	elif ((current_minor == wanted_minor)); then
	    if ((current_patch < wanted_patch)); then
		echo "normalupgrade"
	    elif ((current_patch > wanted_patch)); then
		echo "unsupported"
	    elif ((current_patch == wanted_patch)); then
	        return 0
	    fi
	fi
    fi
}
