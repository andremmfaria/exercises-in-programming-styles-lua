-- Função auxiliar que retorna um iterator que ordena a tabela
-- Código obtido em http://stackoverflow.com/questions/15706270/sort-a-table-in-lua
local function spairs(t, order)
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end
 
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end
    
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

-- Calcula a frequência das palavras e ordena a lista
local function calculate_frequencies(word_list)
    local frequencies = {}
    for _, word in ipairs(word_list) do
        if frequencies[word] then
            frequencies[word] = frequencies[word] + 1
        else
            frequencies[word] = 1
        end
    end
  
    local sorted_frequencies = {}
    local comparator = function(t,a,b) return t[b] < t[a] end
    for word, frequency in spairs(frequencies, comparator) do
        local pair = {word = word, frequency = frequency}
        table.insert(sorted_frequencies, pair)
    end
    return sorted_frequencies
end

return calculate_frequencies
