-- Isso é um comentário em Haskell
{- Função que verifica se duas listas são iguais

O que é serem iguais?

- Mesmo número de elementos
- Possuírem os mesmo elementos
- Os elementos estarem na mesma posição

[1,2,3] e [1,2,3] = True 
[3,2,1] e [1,2,3] = False
[] e [1,2,3] = False
[1,2] e [] = False -}

comp_list :: [Int] -> [Int] -> Bool
comp_list [] [] = True
comp_list [] _ = False
comp_list _ [] = False
comp_list (a:b) (c:d) | (a == c) = comp_list b d
                      | otherwise = False
