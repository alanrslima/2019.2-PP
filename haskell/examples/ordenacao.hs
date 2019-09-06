-- Declaração de uma lista
lista :: [Int]
lista = [5,4,2,10,1,9]

-- Função que identifica o menor número de uma lista
get_menor :: [Int] -> Int
get_menor [x] = x
get_menor (x:xs) | (x < get_menor xs) = x
                 | otherwise = get_menor xs
            

-- Função que remove o menor número de uma lista
remove_menor :: [Int] -> [Int]
remove_menor [] = []
remove_menor (x:xs) | (x == (get_menor(x:xs))) = xs
                    | otherwise = (x:remove_menor xs)


-- Função auxiliar usada para ordenar uma lista, de forma com que os parâmetros são uma lista vazia e a lista a ser ordenada
aux_ordena :: [Int] -> [Int] -> [Int]
aux_ordena lista_ordenada [] = lista_ordenada
aux_ordena lista_ordenada (x:xs) = aux_ordena (lista_ordenada++[get_menor (x:xs)]) (remove_menor (x:xs))


-- Função que ordena uma lista de inteiros de forma crescente
ordena :: [Int] -> [Int]
ordena [] = []
ordena lista = aux_ordena [] lista