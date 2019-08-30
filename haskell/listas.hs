-- Função que verifica se duas listas são iguais
-- O que é serem iguais?
-- - Mesmo número de elementos
-- - Possuírem os mesmo elementos
-- - Os elementos estarem na mesma posição
comp_list :: [Int] -> [Int] -> Bool
comp_list [] [] = True
comp_list [] _ = False
comp_list _ [] = False
comp_list (a:b) (c:d) | (a == c) = comp_list b d
                      | otherwise = False


-- Função que recebe uma lista e retorna o inverso dessa lista
inv_list :: [t] -> [t]
inv_list [] = []
inv_list (x:xs) = inv_list xs ++ [x]


-- Calcula o tamanho de uma lista
size_list [] = 0
size_list (x:xs) = 1 + size_list xs


-- Verifica se um item pertence a lista 
pertence :: [Int] -> Int -> Bool
pertence [] _ = False
pertence (x:xs) n | (x == n) = True
                  | otherwise = pertence xs n


-- Verifica maior elemento de uma lista
maior :: [Int] -> Int
maior [x] = x
maior (x:xs) | (x > maior xs) = x
             | otherwise = maior xs


-- Verifica se todos os numeros de uma lista são pares
todos_pares :: [Int] -> Bool
todos_pares [] = True
todos_pares (x:xs) | (mod x 2 == 1) = False
                   | otherwise = todos_pares xs
