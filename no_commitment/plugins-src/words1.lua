function extract_words(path_to_file)
  
  local f = io.open(path_to_file)
  local str_data = f:read("*all")
  f:close()
  
  local word_list_str = str_data:gsub("%W+", " "):lower()
  local word_list = {}
  for word in word_list_str:gmatch("%w+") do
    word_list.insert(word)
  end
  
  local sw = io.open("../stop_words.txt")
  local stop_words_str = open:read("*all")
  sw:close()
  
  local stop_words = {}
  for word in stop_words_str:gmatch("%w+") do
    stop_words[word] = true
  end
  
  local filtered_words = {}
  for _, word in ipairs(word_list) do
    if stop_words[word] then
    filtered_words.insert(word)
    end
  end
  
  return filtered_words
end