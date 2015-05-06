TFTheOne = {}
TFTheOne.__index = TFTheOne

function TFTheOne.create(v)
    local tftheone = {}
    setmetatable(tftheone, TFTheOne)
    tftheone._value = v
    return tftheone
end

function TFTheOne:bind(func)
    self._value = func(self._value)
    return self
end

function TFTheOne:printme()
    print(self._value)
end



--[[def read_file(path_to_file):
    with open(path_to_file) as f:
        data = f.read()
    return data --]]

function ler_arquivo(caminho_do_arquivo)
	local arquivo = io.open(caminho_do_arquivo, "r")
    local conteudo_arquivo = arquivo:read("*all")

    arquivo:close()
    return conteudo_arquivo
end

--[[def filter_chars(str_data):
    pattern = re.compile('[\W_]+')
    return pattern.sub(' ', str_data)--]]

function filtra_caracteres(texto)
    local expressao_regular = '[\W_]+'
    local novo_texto, numero_alteracoes = string.gsub(texto, expressao_regular, " ")
    return novo_texto
end

--[[def normalize(str_data):
    return str_data.lower()--]]

function normaliza(texto)
    return texto:lower()
end

--[[def scan(str_data):
    return str_data.split()--]]


function divide(texto)
    resultado = {};
    for palavra in (texto .. " "):gmatch("(.-)" .. " ") do
        table.insert(resultado, palavra);
    end

    return resultado;
end

--[[def remove_stop_words(word_list):
    with open('../stop_words.txt') as f:
        stop_words = f.read().split(',')
    # add single-letter words
    stop_words.extend(list(string.ascii_lowercase))
    return [w for w in word_list if not w in stop_words] --]]

function minusculas_ascii()
    local letras = {}
    for i = 0,25 do table.insert(letras, string.char(string.byte('a') + i)) end
    return letras
end

function concatenar_tabelas(tabela_inicio,tabela_fim)
    for indice_tabela = 1 , #tabela_fim  do
        table.insert(tabela_inicio, tabela_fim[indice_tabela ])
    end
end

function remover_palavras(lista_palavras, palavras_remover)
    local lista_com_palavras_removidas = {}
    for _, palavra in ipairs(lista_palavras) do
        remover = false
        for _, palavra_remover in ipairs(palavras_remover) do
            if palavra_remover == palavra then
                remover = true
                break
            end
        end
        if not(remover) then
            table.insert(lista_com_palavras_removidas, palavra)
        end
    end

    return lista_com_palavras_removidas
end


function remove_palavras_parada(lista_palavras)
    local arquivo = io.open('stop_words.txt', "r")
    local palavras_parada = {}

    for palavra in (arquivo:read("*all") .. ","):gmatch("(.-)" .. ",") do
        table.insert(palavras_parada, palavra);
    end

    concatenar_tabelas(palavras_parada, minusculas_ascii())

    local lista_com_palavras_removidas = remover_palavras(lista_palavras, palavras_parada)

    return  lista_com_palavras_removidas
end


--[[def frequencies(word_list):
    word_freqs = {}
    for w in word_list:
        if w in word_freqs:
            word_freqs[w] += 1
        else:
            word_freqs[w] = 1
    return word_freqs --]]


function define_frequencias(lista_palavras)
    local frequencia_palavras = {}

    for _, palavra in  ipairs(lista_palavras) do
        --if palavra == "chumps" then print "ok, é isso ai" end
        if frequencia_palavras[palavra] ~= nil then
            frequencia_palavras[palavra] = frequencia_palavras[palavra] + 1
        else
            frequencia_palavras[palavra] = 1
        end
    end

    return frequencia_palavras
end

--[[def sort(word_freq):
    return sorted(word_freq.iteritems(), key=operator.itemgetter(1), reverse=True)--]]

function sort(frequencia_palavras)
    return frequencia_palavras
end

--[[def top25_freqs(word_freqs):
    top25 = ""
    for tf in word_freqs[0:25]:
        top25 += str(tf[0]) + ' - ' + str(tf[1]) + '\n'
    return top25--]]

function top25_frequencias(frequencia_palavras)
    top25 = ""
    contador = 1
    for palavra, frequencia in pairs(frequencia_palavras) do
        if contador > 25 then break end
        top25 = top25 .. palavra .. ' - ' .. frequencia .. '\n'
        contador = contador + 1
    end
    print (top25)
    return top25
end


function soma2(numero)
    return numero + 2
end

tftheone = TFTheOne.create(arg[1])
:bind(ler_arquivo)
:bind(filtra_caracteres)
:bind(normaliza)
:bind(divide)
:bind(remove_palavras_parada)
:bind(define_frequencias)
:bind(sort)
:bind(top25_frequencias)
:printme()
