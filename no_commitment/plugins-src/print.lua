-- Imprime as palavras
local function print_top25(frequencies)
    for i = 1, math.min(#frequencies, 25) do
        print(frequencies[i].word .. "  -  " .. frequencies[i].frequency)
    end
end

return print_top25
