-- Soma duas tuplas resultando em uma terceira tupla
func :: (Int, Int) -> (Int, Int) -> (Int, Int)
func (a,b) (c,d) = (a+c, b+d)


-- Seleciona items de diferentes possições de uma tupla
nomes :: (String, String, String)
nomes = ("Marcos", "Geek", "Haskell")

select_prim (x, _, _) = x
select_sec (_, y, _) = y
select_ter (_, _, z) = z

