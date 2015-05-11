#!/usr/bin/lua

-- Obtém módulo auxiliar de leitura de arquivos ini
local inifile = require "inifile"

-- Lê arquivo de configuração e carrega os plugins
local configTable = inifile.parse("config.ini")
local words_plugin = dofile(configTable.Plugins.words)
local frequencies_plugin = dofile(configTable.Plugins.frequencies)
local print_plugin = dofile(configTable.Plugins.print)

-- Executa os plugins
print_plugin(frequencies_plugin(words_plugin(arg[1])))
