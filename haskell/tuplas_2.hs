nomes :: (String, String, String)
nomes = ("Marcos", "Geek", "Haskell")

select_prim (x, _, _) = x
select_sec (_, y, _) = y
select_ter (_, _, z) = z

