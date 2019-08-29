{- Função que recebe uma lista e retorna o inverso dessa lista

Exemplo de entrada: [1,2,3]
Exemplo de saída: [3,2,1] -}

inv_aux :: [t] -> [t] -> [t]
inv_aux [] l_inv = l_inv
inv_aux (x:xs) l_inv = inv_aux xs l_inv++[x]

inv_list :: [t] -> [t]
inv_list [] = []
inv_list l = inv_aux l []

