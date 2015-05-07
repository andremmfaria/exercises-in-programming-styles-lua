#!/usr/bin/sh

for file in *.lua; do
    out=$(echo $file | sed -e "s/lua$/out/")
    luac -o $out $file
done
mv *.out ../plugins
