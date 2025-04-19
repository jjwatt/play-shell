#!/usr/bin/env bash

: "${CURRENT_DIR:=/opt/hap/updater/current}"

get_current_version_string() {
    shopt -s nullglob dotglob
    files=("$CURRENT_DIR"/*)
    shopt -u nullglob dotglob
    if [[ "${#files[@]}" -gt 0 ]]; then
	local highest_file="$(printf "%s\n" | sort -r | sed 1q)"
	local version_string="${highest_file##*/}"
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
}

