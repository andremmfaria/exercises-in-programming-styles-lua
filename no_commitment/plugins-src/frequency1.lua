function top25(word_list)
  wf = {}
  for key, word in pairs(word_list) do
    if wf[word] then
      wf[word] = wf[word] + 1
    else
      wf[word] = 1
    end
  end
  
  word_freqs = {}
  for key, value in spairs(wf, function(t,a,b) return t[b] < t[a] end) do
    word_freqs[key] = value
  end
  
  return word_freqs
end

--Key, Value iterator
function spairs(t, order)
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
