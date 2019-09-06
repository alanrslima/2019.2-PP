-- Calcula o fatorial de um número
fatorial :: Int -> Int
fatorial 0 = 1
fatorial 1 = 1
fatorial n = fatorial(n-1)*n
