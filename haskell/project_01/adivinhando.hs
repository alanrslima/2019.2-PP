{-
	Paradigmas de Programação
	Professora: Milene Serrano
	Alunos:
		André Bargas
		Alan Lima
		André Goretti
		Ian Rocha
	Jogo do Adivinha em Haskell
-}

import System.Random
import Text.Read 

-- função principal para iniciar o jogo
main :: IO ()
main = do
  putStrLn "Voce vai tentar adivinhar um número de 1 a 100"
  chute <- (randomIO :: IO Int)
  jogar (chute `mod` 100)
  putStrLn "Jogar novamente?? (S/N)"
  resposta <- getLine
  if resposta == "S" then
    main
  else
    return ()


-- função que executa o jogo com suas regras
jogar :: Int -> IO ()
jogar n = go 5
  where
  go 0 = putStrLn "Voce perdeu!"
  go n = do
    putStr "Insira seu chute: "
    chute <- validar 
    if n == chute then
      putStrLn "Voce Venceu!!!"
    else
      if n < chute then
          putStrLn "Ta pensando muito alto!" >> go (n-1)
      else
          putStrLn "Ta pensanto muito pouco" >> go (n-1)


-- função para validar a entrada sendo um número de 1 a 100
validar :: IO Int
validar = do
  s <- getLine
  case (readMaybe s :: Maybe Int) of
    Nothing -> putStr "Invalido, por favor insira um numero valido" >> validar
    Just x -> return x