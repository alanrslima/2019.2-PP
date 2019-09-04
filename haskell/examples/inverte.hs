inverte :: [a] -> [a]
inverte [] = []
inverte (x:xs) = (inverte xs)++[x]