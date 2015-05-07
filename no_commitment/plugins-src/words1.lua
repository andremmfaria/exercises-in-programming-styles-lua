-- Extrai as palavras do arquivo e remove as palavras vazias
local function extract_words(path_to_file)
    local input_file = io.open(path_to_file)
    local raw_input = input_file:read('*all')
    input_file:close()

    local filtered_input = raw_input:gsub('%W+', ' '):lower()
    local word_list = {}
    for word in filtered_input:gmatch('%w%w+') do
        table.insert(word_list, word)
    end

    local stops_file = io.open('../stop_words.txt')
    local stops_str = stops_file:read('*all')
    stops_file:close()

    local stop_words = {}
    for word in stops_str:gmatch('%w+') do
        stop_words[word] = true
    end

    local filtered_words = {}
    for _, word in ipairs(word_list) do
        if not stop_words[word] then
            table.insert(filtered_words, word)
        end
    end
    return filtered_words
end

return extract_words
