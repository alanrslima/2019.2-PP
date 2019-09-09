import Data.Array

-- O primeiro parâmetro indica a dimensão do vetor, o segundo parâmetro é um vetor em sim.
-- Onde o primeiro valor da tupla indica a posição do elemento e o segundo indica o elemento em si.
-- get_array = array (1,4) [(1, 'A'), (2, 'B'), (3, 'C'), (4, 'D')]

-- O comando elems get_array irá retornar todos os elementos do vetor.
-- O comando get_array ! x retorna o elemento que está na posição x
-- O comando bounds get_array retorna as dimensões do vetor

-- Criação de uma matriz 2x2
get_array = array ((1,1), (2,2)) [((1,1), 'A'), ((1,2), 'B'), ((2,1), 'C'), ((2,2), 'D')]