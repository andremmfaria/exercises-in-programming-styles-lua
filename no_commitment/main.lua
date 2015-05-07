#!/usr/bin/lua
require 'inifile'

function main()
  local tfwords, tffreqs = load_plugins()
  tfwords()
  tffreqs()
  local word_freqs = top25(extract_words(arg[1]))
  for key, value in pairs(word_freqs) do
    print(key .. "-" .. value)
  end
end

function load_plugins()
  local configTable = inifile.parse("config.ini")
  local words_plugin = configTable.Plugins.words
  local frequencies_plugin = configTable.Plugins.frequencies
  local tfwords = loadfile(words_plugin)
  local tffreqs = loadfile(frequencies_plugin)
  return tfwords, tffreqs
end

main()
