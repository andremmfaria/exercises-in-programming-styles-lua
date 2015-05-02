#!/bin/lua
local stops = "," .. io.input('../stop_words.txt', 'r'):read("*a")
local words = {}
for word in io.input(arg[1], 'r'):read("*a"):lower():gmatch("%w%w+") do
    if not stops:find("," .. word .. ",") then
        words[word] = not words[word] and 1 or words[word] + 1
    end
end
local sorted = {}
for word, frequency in pairs(words) do
    table.insert(sorted, {word = word, frequency = frequency})
end
table.sort(sorted, function(a, b) return a.frequency > b.frequency end)
for i = 1 , math.min(#sorted, 25) do
    print(sorted[i].word .. "  -  " .. sorted[i].frequency)
end
