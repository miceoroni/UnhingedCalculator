#!/bin/sh
printf '\033c\033]0;%s\a' Unhinged Calculator
base_path="$(dirname "$(realpath "$0")")"
"$base_path/unhinged_calc" "$@"
