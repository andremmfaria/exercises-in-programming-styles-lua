#!/usr/bin/sh

for file in plugins-src/*.lua; do
    out=$(echo $file | sed -e "s/lua$/out/")
    luac -o $out $file
    mv $out plugins
done
