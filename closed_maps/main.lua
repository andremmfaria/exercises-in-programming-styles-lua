#!/bin/lua

-- Objeto responsável por ler e armazenar as palavras do arquivo de entrada
local words_storage_obj = {}
words_storage_obj.words = {}
words_storage_obj.init = function(file_name)
    for line in io.lines(file_name) do
        for word in line:gmatch("%w%w+") do
            table.insert(words_storage_obj.words, word:lower())
        end
    end
end
words_storage_obj.get_words = function()
    return words_storage_obj.words
end

-- Objeto responsável por ler e armazenar as palavras vazias
local stop_words_obj = {}
stop_words_obj.stop_words = {}
stop_words_obj.init = function()
    for line in io.lines("../stop_words.txt") do
        for word in line:gmatch("%w+") do
            stop_words_obj.stop_words[word] = true
        end
    end
end
stop_words_obj.is_stop_word = function(word)
    return stop_words_obj.stop_words[word]
end

-- Objeto responsável por contar a frequência das palavras
local word_freqs_obj = {}
word_freqs_obj.frequencies = {}
word_freqs_obj.increment_count = function(word)
    if not word_freqs_obj.frequencies[word] then
        word_freqs_obj.frequencies[word] = 1
    else
        word_freqs_obj.frequencies[word] = word_freqs_obj.frequencies[word] + 1
    end
end
word_freqs_obj.sorted_frequencies = function()
    local sorted = {}
    for word, frequency in pairs(word_freqs_obj.frequencies) do
        table.insert(sorted, {word = word, frequency = frequency})
    end
    table.sort(sorted, function(a, b) return a.frequency > b.frequency end)
    return sorted
end

-- Executa o programa
words_storage_obj.init(arg[1])
stop_words_obj.init()

for _, word in pairs(words_storage_obj.get_words()) do
    if not stop_words_obj.is_stop_word(word) then
        word_freqs_obj.increment_count(word)
    end
end
frequencies = word_freqs_obj.sorted_frequencies()
for i = 1 , math.min(#frequencies, 25) do
    print(frequencies[i].word .. "  -  " .. frequencies[i].frequency)
end
