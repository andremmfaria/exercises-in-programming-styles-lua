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

function ler_arquivo(caminho_do_arquivo)
	local arquivo = io.open(caminho_do_arquivo, "r")
    local conteudo_arquivo = arquivo:read("*all")

    arquivo:close()
    return conteudo_arquivo
end

function filtra_caracteres(texto)
    local expressao_regular = '%W+'
    local novo_texto, numero_alteracoes = string.gsub(texto, expressao_regular, " ")
    return novo_texto
end

function normaliza(texto)
    return texto:lower()
end

function divide(texto)
    lista_palavra = {};
    for palavra in texto:gmatch("%w+") do
        table.insert(lista_palavra, palavra);
    end
    return lista_palavra;
end

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
    local arquivo = io.open('../stop_words.txt', "r")
    local palavras_parada = {}

    for palavra in (arquivo:read("*all") .. ","):gmatch("(.-)" .. ",") do
        table.insert(palavras_parada, palavra);
    end

    concatenar_tabelas(palavras_parada, minusculas_ascii())

    local lista_com_palavras_removidas = remover_palavras(lista_palavras, palavras_parada)

    return  lista_com_palavras_removidas
end

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

function ordenar(frequencia_palavras)
    local frequencia_ordenada = {}
    for palavra, frequencia in pairs(frequencia_palavras) do
        table.insert(frequencia_ordenada, {palavra = palavra, frequencia = frequencia})
    end
    table.sort(frequencia_ordenada, function(a, b) return a.frequencia > b.frequencia end)

    return frequencia_ordenada
end

function top25_frequencias(frequencia_palavras)
    top25 = ""
    contador = 1
    for _, par_palavra_frequencia in ipairs(frequencia_palavras) do
        if contador > 25 then break end
        top25 = top25 .. par_palavra_frequencia.palavra .. '  -  ' .. par_palavra_frequencia.frequencia .. '\n'
        contador = contador + 1
    end

    return top25
end


tftheone = TFTheOne.create(arg[1])
:bind(ler_arquivo)
:bind(filtra_caracteres)
:bind(normaliza)
:bind(divide)
:bind(remove_palavras_parada)
:bind(define_frequencias)
:bind(ordenar)
:bind(top25_frequencias)
:printme()
