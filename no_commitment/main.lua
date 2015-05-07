#!/usr/bin/lua

-- Obtém módulo auxiliar de leitura de arquivos ini
local inifile = require "inifile"

-- Lê arquivo de configuração
local configTable = inifile.parse("config.ini")
local words_plugin = dofile(configTable.Plugins.words)
local frequencies_plugin = dofile(configTable.Plugins.frequencies)

-- Executa os plugins
word_list = words_plugin(arg[1])
frequencies = frequencies_plugin(word_list)

-- Imprime as palavras
for i = 1, math.min(#frequencies, 25) do
    print(frequencies[i].word .. "  -  " .. frequencies[i].frequency)
end
