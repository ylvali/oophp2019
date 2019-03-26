#!/usr/bin/env bash
cd me/kmom05/eshop1 || exit 1
echo "Doing a silent 'npm --quiet install'"
npm --quiet install > /dev/null 2>&1
if (( $? )); then
    cat npm-debug.log
    exit 1
fi
