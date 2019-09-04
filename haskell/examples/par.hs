-- Verifica se um número é par
if_par :: Int -> Bool
if_par n = if (mod n 2 == 0) then True else False


case_par :: Int -> Bool
case_par n = case (mod n 2 == 0) of
             True -> True
             False -> False


guarda_par :: Int -> Bool
guarda_par n | (mod n 2 == 0) = True
             | otherwise = False