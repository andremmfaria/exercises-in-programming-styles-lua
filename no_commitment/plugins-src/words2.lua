-- Extrai as palavras do arquivo e remove as palavras vazias
local function extract_words(path_to_file)
    local stops = {}
    for line in io.lines('../stop_words.txt') do
        for word in line:gmatch("%w+") do
            stops[word] = true
        end
    end
    local words = {}
    for line in io.lines(path_to_file) do
        for word in line:lower():gmatch('%w%w+') do
            if not stops[word] then
                table.insert(words, word)
            end
        end
    end
    return words
end

return extract_words
