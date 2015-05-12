#!/usr/bin/lua
-- AE1: endereço (string) para o arquivo de palavras descartáveis 
-- C1: retornar string contida no arquivo
local stops = "," .. io.input('../stop_words.txt', 'r'):read("*a")
-- AS1: string do conteúdo do arquivo todo

-- AE2: endereço para o arquivo com texto (string de entrada do programa)
-- C2: selecionar proxima palavra lida no texto em letras minúsculas
local words = {}
for word in io.input(arg[1], 'r'):read("*a"):lower():gmatch("%w%w+") do
-- AS2: palavra (string) corrente do texto

    -- AE3:  mapa (table) vazio, string de palavras descartáveis, palavra corrente
    -- C3: atualizar mapa se palavra corrente não for descartável
    if not stops:find("," .. word .. ",") then
        words[word] = not words[word] and 1 or words[word] + 1
    end    
end
-- AS3: mapa (table) de palavras em frequências

-- AE4: table vazia, mapa de palavras em frequências
-- C4: copiar table e ordenar por frequências
local sorted = {}
for word, frequency in pairs(words) do
    table.insert(sorted, {word = word, frequency = frequency})
end

table.sort(sorted, function(a, b) return a.frequency > b.frequency end)
-- AS4: table de palavras ordenadas por frequência

-- AE5: table de palavras ordenadas por frequência
-- C5: imprimir até 25 mais frequentes
for i = 1 , math.min(#sorted, 25) do
    print(sorted[i].word .. "  -  " .. sorted[i].frequency)
end
-- AS5: I/O
