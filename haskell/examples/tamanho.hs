-- Calcula o tamanho de uma lista
my_length :: [a] -> Int
my_length [] = 0
my_length (x:xs) = 1 + my_length xs