#!/usr/bin/env bash

: "${CURRENT_DIR:=/opt/hap/updater/current}"

get_current_version_string() {
    shopt -s nullglob dotglob
    files=("$CURRENT_DIR"/*)
    shopt -u nullglob dotglob
    if [[ "${#files[@]}" -gt 0 ]]; then
	local highest_file version_string
	highest_file="$(printf "%s\n" "${files[@]}" | sort -r | sed 1q)"
	version_string="${highest_file##*/}"
	echo "$version_string"
	return 0
    else
	return 1
    fi
}

get_current_version() {
    local vs="$(get_current_version_string)"
    if [[ -z $vs ]]; then
	echo "${vs##*_}"
	return 0
    else
	return 1
    fi
}

build_file_list() {
    local dir="$1"
    find "$dir" -type f > filelist.txt
}

download_single_file_with_retries() {
    remote_file="$1"
    download_dir="$2"
    local max_retries=5
    local initial_delay=5
    local random_range=5
    local random_variation=0
    local attempt=1
    while ((attempt <= max_retries)); do
	if download_single_file "$remote_file" "$download_dir"; then
	    logInfo "Downloaded $remote_file"
	    return 0
	else
	    logInfo "Download failed (attempt $attempt)"
	    if ((attempt < max_retries)); then
		# Base exponential delay
		delay=$(( initial_delay * (2**(attempt - 1)) ))
		random_variation=$(( RANDOM % random_range + 1 ))

		# Randomly add or subtract the variation
		if (( RANDOM % 2 == 0 )); then
		    randomized_delay=$(( delay + random_variation ))
		else
		    randomized_delay=$(( delay - random_variation ))
		fi
		if (( randomized_delay < initial_delay )); then
		    randomized_delay=$initial_delay
		fi
		logInfo "Waiting $randomized_delay before retrying"
		if [[ -z $UNITTESTING ]]; then
		    sleep "$randomized_delay"
		fi
	    fi
	    attempt=$(( attempt + 1 ))
	fi
    done
    logError "Failed to download $remote_file after $max_retries attempts."
}
