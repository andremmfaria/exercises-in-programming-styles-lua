#!/usr/bin/lua

-- Classe que representa um monade identidade
MonadeId = {}
MonadeId.__index = MonadeId

function MonadeId.criar(valor)
    local monade = {}
    setmetatable(monade, MonadeId)
    monade.valor = valor
    return monade
end

function MonadeId:ligar(funcao)
    self.valor = funcao(self.valor)
    return self
end

function MonadeId:imprimir()
    io.write(self.valor)
end

-- Funções que calculam a relação termo-frequência
function ler_arquivo(caminho_do_arquivo)
	local arquivo = io.open(caminho_do_arquivo, 'r')
    local conteudo_arquivo = arquivo:read('*a')
    arquivo:close()
    return conteudo_arquivo
end

function dividir_palavras(texto)
    local lista_palavras = {}
    for palavra in texto:gmatch('%w%w+') do
        table.insert(lista_palavras, palavra:lower())
    end
    return lista_palavras
end

function remover_palavras_vazias(lista_palavras)
    local palavras_vazias = {}
    for linha in io.lines('../stop_words.txt') do
        for palavra in linha:gmatch('%w+') do
            palavras_vazias[palavra] = true
        end
    end
    local lista_com_palavras_removidas = {}
    for _, palavra in ipairs(lista_palavras) do
        if not palavras_vazias[palavra] then
            table.insert(lista_com_palavras_removidas, palavra)
        end
    end
    return lista_com_palavras_removidas
end

function definir_frequencias(lista_palavras)
    local frequencia_palavras = {}
    for _, palavra in ipairs(lista_palavras) do
        if frequencia_palavras[palavra] then
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
        local par = {palavra = palavra, frequencia = frequencia}
        table.insert(frequencia_ordenada, par)
    end
    local comparar_frequencias = function(a, b)
        return a.frequencia > b.frequencia
    end
    table.sort(frequencia_ordenada, comparar_frequencias)
    return frequencia_ordenada
end

function achar_frequencia_de_palavras_ordenada (texto)
    local lista_palavras = dividir_palavras(texto)
    local lista_sem_palavras_vazias = remover_palavras_vazias(lista_palavras)
    local frequencias = definir_frequencias(lista_sem_palavras_vazias)
    local frequencia_ordenada = ordenar(frequencias)
    return frequencia_ordenada
end

function selecionar_25_mais_frequentes(lista_frequencia_palavras)
    local mais_frequentes = ""
    local contador = 1
    for _, par in ipairs(lista_frequencia_palavras) do
        if contador > 25 then break end
        mais_frequentes = mais_frequentes .. par.palavra .. '  -  ' ..
                par.frequencia .. '\n'
        contador = contador + 1
    end
    return mais_frequentes
end

monade_id = MonadeId.criar(arg[1])
:ligar(ler_arquivo)
:ligar(achar_frequencia_de_palavras_ordenada)
:ligar(selecionar_25_mais_frequentes)
:imprimir()
