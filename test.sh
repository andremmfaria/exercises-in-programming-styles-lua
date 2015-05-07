#!/bin/sh

programs="code_golf closed_maps no_commitment the_one"

for p in $programs; do
    cd $p
    ./main.lua ../pride_and_prejudice.txt > output.txt || exit
    if ! cmp --silent output.txt ../pride_and_prejudice_result.txt; then
        echo "$p failed!"
        printf "%-24s%s\n" "expected" "result"
        diff -y -W 40 ../pride_and_prejudice_result.txt output.txt
        exit 1
    fi
    echo "test succeeded: $p"
    rm output.txt
    cd ..
done
echo "done!"
