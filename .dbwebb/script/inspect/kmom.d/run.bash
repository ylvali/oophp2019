#!/usr/bin/env bash
#
# Execute all scripts in a subdirectory
#

# Usage
if (( $# != 1 )); then
    printf "Usage: run.bash <kmom_number>\n"
    exit 1
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
KMOM=$1
export COURSE_REPO="$PWD"

if [[ ! -d "$DIR/$KMOM" ]]; then
    printf "No such directory '%s'\n" "$DIR/$KMOM"
    exit 1
fi

MSG_OK="\033[0;30;42mOK\033[0m"
MSG_DONE="\033[1;37;40mDONE\033[0m"
#MSG_WARNING="\033[43mWARNING\033[0m"
MSG_FAILED="\033[0;37;41mFAILED\033[0m"
PROMPT=">>>"



#
# Print a header
#
function header {
    printf "%s -------------- %-20s -------------------------\n" "$PROMPT" "$1"
}

#
# Print information text
#
function text {
    printf "$@"
}

header "Start"
text "%s Running all scripts in '%s'.\n" "$PROMPT" "$DIR/$KMOM"

summary=
if ! compgen -G "$DIR/$KMOM/??*_*.bash" > /dev/null; then
    printf "\n$MSG_DONE No script to execute.\n"
    exit 0
fi

for file in $DIR/$KMOM/??*_*.bash; do
    output=
    target=$( basename "$file" )
    echo && header "$target"

    bash "$file"
    if (( $? )); then
        output="$MSG_FAILED $target\n"
    else
        output="$MSG_OK $target\n"
    fi
    printf "$output"
    summary="$summary$output"
done

printf "\n$MSG_DONE All scripts were executed.\n"
header "Summary"
printf "$summary"
