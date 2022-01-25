#!/bin/bash

# Clears screen and reruns make when the target C file changes
# Example: `./watch.sh test` will watch src/test.c

echo "Compiling $1.c..."

while :
do
    result=$(make FILE="$1" 2>&1)

    clear
    echo "$result"
    echo ""
    echo "Watching $1.c."
    echo "Press Ctrl+C to exit."

    inotifywait -qq --event close_write --format '%w' src/"$1".c

    echo ""
    echo "Recompiling..."
done
