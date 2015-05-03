for file in *.lua; do luac -o $file.out $file; done;
for file in *.lua.out; do mv "$file" "${file%.lua.out}.out"; done;
mv *.out ../plugins