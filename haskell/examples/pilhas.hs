-- Adiciona um item em um pilha
push :: [Int] -> Int -> [Int]
push pilha x = pilha ++ [x]

-- Verifica qual o ultimo elemento de um lista
top :: [Int] -> Int
top [x] = x
top (x:xs) = top xs

-- Retira o ultimo elemento de uma lista
pop :: [Int] -> [Int]
pop [] = error "Pilha vazia"
pop (x:xs) | (x == (top (x:xs))) = xs
           | otherwise = x:(pop xs)

-- Verifica se uma lista está vazia
is_empty :: [Int] -> Bool
is_empty [] = True
is_empty _ = False