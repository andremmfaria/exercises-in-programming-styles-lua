-- Calcula a frequência das palavras e ordena a lista
local function calculate_frequencies(word_list)
    local frequencies = {}
    for _, word in ipairs(word_list) do
        frequencies[word] = frequencies[word] and frequencies[word] + 1 or 1
    end
    local sorted = {}
    for word, frequency in pairs(frequencies) do
        table.insert(sorted, {word = word, frequency = frequency})
    end
    table.sort(sorted, function(a, b) return a.frequency > b.frequency end)
    return sorted
end

return calculate_frequencies
