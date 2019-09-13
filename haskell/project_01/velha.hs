{-
	Jogo da Velha em haskell
-}

import Control.Exception
import System.IO
import System.IO.Error
import System.Process
import Data.List
import Data.Function


-- definição dos tipos dos dados
type Jogadores = [Jogador]
type Nome = String
type Pontuacao = Int
type Vez = Int
type Tabela = [Char]
data Jogador = Jogador Nome Pontuacao
					deriving (Show, Read)


-- função que recebe uma String e retorna uma IO String
getString :: String -> IO String
getString str = do
			putStr str
			res <- getLine
			return res


-- função que inicia o programa
inicio :: IO ()
inicio = do
		{catch (ler_arquivo) tratar_erro;}
		where
			-- tenta ler o arquivo
			ler_arquivo = do
			{
				arq <- openFile "dados.txt" ReadMode; -- abre o arquivo para leitura
				dados <- hGetLine arq; -- ler o conteúdo do arquivo
				hClose arq; -- fecha o arquivo
				menu (read dados); -- passa os dados para a função menu
				return ()
			}
			tratar_erro erro = if isDoesNotExistError erro then do
			{
				-- se o arquivo NÃO existir, então cria o arquivo
				arq <- openFile "dados.txt" WriteMode; -- abre o arquivo para escrita
				hPutStrLn arq "[]"; -- escreve uma lista vazia no arquivo
				hClose arq; -- fecha o arquivo
				menu []; -- passa uma lista vazia para o menu
				return ()
			}
			else
				ioError erro


-- função que exibe o Menu
menu :: Jogadores -> IO Jogadores
menu dados = do
		system "clear" -- limpa a tela (windows somente)
		putStrLn ">>>>>> Jogo da Velha <<<<<<<"
		putStrLn "\nDigite 1 para cadastrar jogador"
		putStrLn "Digite 2 para jogar"
		putStrLn "Digite 3 para visualizar o ranking"
		putStrLn "Digite 0 para sair"
		putStr "Opção: "
		op <- getChar
		getChar -- descarta o Enter
		executarOpcao dados op


-- função para manipular a opção escolhida pelo usuário
executarOpcao :: Jogadores -> Char -> IO Jogadores
executarOpcao dados '1' = cadastrarJogador dados
executarOpcao dados '2' = prepararJogo dados
executarOpcao dados '3' = do
				putStrLn "\nRanking dos jogadores:\n"
				if (null dados) then do
					putStrLn ("Não há jogadores cadastrados!")
				else
					-- a função ordenar ordena crescentemente pela pontuação
					exibirRanking (reverse (ordenar dados))
				putStr "\nPressione <Enter> para voltar ao menu..."
				getChar
				menu dados
executarOpcao dados '0' = do
				putStrLn ("\nTchuazinho)\n")
				return dados
executarOpcao dados _ = do
				putStrLn ("\nOpção inválida! Tente novamente...")
				putStr "\nPressione <Enter> para voltar ao menu..."
				getChar
				menu dados


-- função responsável pelo cadastro de jogadores
cadastrarJogador :: Jogadores -> IO Jogadores
cadastrarJogador dados = do
				nome <- getString "\nDigite um nome de usuário: "
				if (existeJogador dados nome) then do
					putStrLn "\nEsse nome já existe, escolha outro."
					putStr "\nPressione <Enter> para continuar..."
					getChar
					menu dados
				else do
					arq <- openFile "dados.txt" WriteMode -- abre o arquivo para escrita
					hPutStrLn arq (show ((Jogador nome 0):dados))
					hClose arq -- fecha o arquivo
					putStrLn ("\nUsuário " ++ nome ++ " cadastrado com sucesso.")
					putStr "\nPressione <Enter> para continuar..."
					getChar
					menu ((Jogador nome 0):dados) -- retorna a nova lista para o menu


-- função que verifica se um jogador existe (o nome do jogador é único)
existeJogador :: Jogadores -> Nome -> Bool
existeJogador [] _ = False
existeJogador ((Jogador n p):xs) nome
			| (n == nome) = True
			| otherwise = existeJogador xs nome


-- função que prepara o início do jogo
prepararJogo :: Jogadores -> IO Jogadores
prepararJogo dados = do
			jogador1 <- getString "\nDigite o nome do primeiro jogador: "
			-- testa se o jogador1 existe
			if not (existeJogador dados jogador1) then do
				putStrLn "\nEsse jogador não existe!"
				putStr "\nPressione <Enter> para continuar..."
				getChar -- descarta o Enter
				menu dados
			else do
				jogador2 <- getString "\nDigite o nome do segundo jogador: "
				if not (existeJogador dados jogador2) then do
					putStrLn "\nEsse jogador não existe!"
					putStr "\nPressione <Enter> para continuar..."
					getChar -- descarta o Enter
					menu dados
				else do
					-- se chegou aqui, é porque os dois jogadores existem
					novoJogo dados jogador1 jogador2


-- função que inicia um novo jogo
novoJogo :: Jogadores -> Nome -> Nome -> IO Jogadores
novoJogo dados jogador1 jogador2 = do
					putStrLn ("\nIniciando o jogo \"" ++
							jogador1 ++ " vs " ++ jogador2 ++ "\" ... ")
					putStrLn ("\nOs quadrados que possuem números NÃO estão marcados.")
					putStrLn ("\n" ++ jogador1 ++ " será o \'X\' e " ++ jogador2 ++ " será o \'O\'. Vamos lá!!")
					{-
						A configuração inicial do tabuleiro é
						['1', '2', '3', '4', '5', '6', '7', '8', '9']
						Numeração da esquerda para direita e de cima para baixo
						Exemplo:
								1 | 2 | 3
							   -----------
							   	4 | 5 | 6
							   -----------
							   	7 | 8 | 9
					-}
					-- passa os dados, a configuração inicial, os jogadores e uma flag que indica de quem é
					-- a vez: 0 quer dizer que a vez é do jogador1 e 1 quer dizer que a vez é do jogador2
					rodarJogo dados ['1', '2', '3', '4', '5', '6', '7', '8', '9'] jogador1 jogador2 0


-- função que exibe o tabuleiro do jogo da velha
-- recebe a lista de jogadores, a tabela, o nome do jogador1, do jogador2 e um inteiro indicando de quem é a vez
rodarJogo :: Jogadores -> Tabela -> Nome -> Nome -> Vez -> IO Jogadores
rodarJogo dados tabela jogador1 jogador2 vez = do
					-- imprime o tabuleiro
					putStrLn ("\n" ++ "                              " ++
								(show (tabela !! 0)) ++ " | " ++ (show (tabela !! 1)) ++ " | " ++ (show (tabela !! 2)) ++
								"\n                              ---------------\n" ++ "                              " ++
								(show (tabela !! 3)) ++ " | " ++ (show (tabela !! 4)) ++ " | " ++ (show (tabela !! 5)) ++
								"\n                              ---------------\n" ++ "                              " ++
								(show (tabela !! 6)) ++ " | " ++ (show (tabela !! 7)) ++ " | " ++ (show (tabela !! 8)) ++
								"\n")
					-- verifica se o jogador1 venceu
					if (venceuJogador1 tabela) then do
						putStrLn ("Parábens " ++ jogador1 ++ "! Você venceu!!")

						-- abre o arquivo para escrita para atualizá-lo
						arq_escrita <- openFile "dados.txt" WriteMode
						hPutStrLn arq_escrita (show (atualizaPontuacao dados jogador1))
						hClose arq_escrita

						-- abre o arquivo para leitura
						arq_leitura <- openFile "dados.txt" ReadMode
						dados_atualizados <- hGetLine arq_leitura
						hClose arq_leitura

						putStr "\nPressione <Enter> para voltar ao menu..."
						getChar
						menu (read dados_atualizados)
					else do
						-- verifica se o jogador2 venceu
						if (venceuJogador2 tabela) then do
							putStrLn ("Parábens " ++ jogador2 ++ "! Você venceu!!")

							-- abre o arquivo para escrita para atualizá-lo
							arq_escrita <- openFile "dados.txt" WriteMode
							hPutStrLn arq_escrita (show (atualizaPontuacao dados jogador2))
							hClose arq_escrita

							-- abre o arquivo para leitura
							arq_leitura <- openFile "dados.txt" ReadMode
							dados_atualizados <- hGetLine arq_leitura
							hClose arq_leitura

							putStr "\nPressione <Enter> para voltar ao menu..."
							getChar
							menu (read dados_atualizados)
						else do
							-- verifica se houve empate
							-- se o tamanho da intersecção entre "123456789" e "tabela" for 0, então deu empate
							if ((length (intersect "123456789" tabela)) == 0) then do
								putStrLn ("Deu empate!")
								putStr "\nPressione <Enter> para voltar ao menu..."
								getChar
								menu dados
							else do
								-- verifica se a vez é do jogador1
								if (vez == 0) then do
									putStr (jogador1 ++ ", é a sua vez! Onde você quer marcar? ")
									op <- getChar
									getChar -- descarta o Enter
									-- testa se a opção é válida
									if not (elem op "123456789") then do
										putStrLn "\nEssa opção NÃO é válida, tente novamente..."
										-- como foi opção inválida, então ainda é a vez do jogador1
										rodarJogo dados tabela jogador1 jogador2 0
									else
										-- se caiu aqui, então é uma opção válida
										-- testa se a opção já foi marcada
										-- se ela não existir na tabela, é porque já foi marcada
										if not (elem op tabela) then do
											putStrLn "\nEssa opção já foi marcada, escolha outra opção..."
											rodarJogo dados tabela jogador1 jogador2 0
										else
											-- se caiu aqui é porque a opção é válida e ainda NÃO foi marcada
											-- passa 1 para indicar que a vez é do jogador2
											-- a nova tabela será o retorno da função obterNovoTabuleiro
											rodarJogo dados (obterNovoTabuleiro tabela vez op) jogador1 jogador2 1
								else do
									putStr (jogador2 ++ ", é a sua vez! Onde você quer marcar? ")
									op <- getChar
									getChar -- descarta o Enter
									if not (elem op "123456789") then do
										putStrLn "\nEssa opção NÃO é válida, tente novamente..."
										-- como foi opção inválida, então ainda é a vez do jogador2
										rodarJogo dados tabela jogador1 jogador2 1
									else
										if not (elem op tabela) then do
											putStrLn "\nEssa opção já foi marcada, escolha outra opção..."
											rodarJogo dados tabela jogador1 jogador2 1
										else
											-- se caiu aqui é porque a opção é válida e ainda NÃO foi marcada
											-- passa 0 para indicar que a vez é do jogador1
											-- a nova tabela será o retorno da função obterNovoTabuleiro
											rodarJogo dados (obterNovoTabuleiro tabela vez op) jogador1 jogador2 0


-- essa função recebe uma lista com a configuração do tabuleiro,
-- a vez, um elemento (opção escolhida pelo jogador), retorna uma nova configuração (nova lista)
obterNovoTabuleiro :: Tabela -> Vez -> Char -> Tabela
obterNovoTabuleiro (x:xs) vez e
			| ((x == e) && (vez == 0)) = (['X'] ++ xs)
			| ((x == e) && (vez == 1)) = (['O'] ++ xs)
			| otherwise = x:(obterNovoTabuleiro xs vez e)


-- essa função verifica se jogador1 venceu
-- recebe a tabela e retorna um Bool
{-
	Para ajudar a verificar os casos, veja como os números estão dispostos:
			1 | 2 | 3
		   -----------
		   	4 | 5 | 6
		   -----------
		   	7 | 8 | 9
	Basta verificar nas linhas, colunas e nas duas diagonais
-}
venceuJogador1 :: Tabela -> Bool
venceuJogador1 tabela
		-- verifica primeiro nas linhas, atenção: o índice começa do 0
		| (((tabela !! 0) == 'X') && ((tabela !! 1) == 'X') && ((tabela !! 2) == 'X')) = True
		| (((tabela !! 3) == 'X') && ((tabela !! 4) == 'X') && ((tabela !! 5) == 'X')) = True
		| (((tabela !! 6) == 'X') && ((tabela !! 7) == 'X') && ((tabela !! 8) == 'X')) = True
		-- verifica nas colunas
		| (((tabela !! 0) == 'X') && ((tabela !! 3) == 'X') && ((tabela !! 6) == 'X')) = True
		| (((tabela !! 1) == 'X') && ((tabela !! 4) == 'X') && ((tabela !! 7) == 'X')) = True
		| (((tabela !! 2) == 'X') && ((tabela !! 5) == 'X') && ((tabela !! 8) == 'X')) = True
		-- verifica nas diagonais
		| (((tabela !! 0) == 'X') && ((tabela !! 4) == 'X') && ((tabela !! 8) == 'X')) = True
		| (((tabela !! 2) == 'X') && ((tabela !! 4) == 'X') && ((tabela !! 6) == 'X')) = True
		| otherwise = False


-- essa função verifica se o jogador2 venceu
-- mesma coisa da função venceuJogador1, com a diferença que no lugar de 'X' tem o 'O'
venceuJogador2 :: Tabela -> Bool
venceuJogador2 tabela
		-- verifica primeiro nas linhas, atenção: o índice começa do 0
		| (((tabela !! 0) == 'O') && ((tabela !! 1) == 'O') && ((tabela !! 2) == 'O')) = True
		| (((tabela !! 3) == 'O') && ((tabela !! 4) == 'O') && ((tabela !! 5) == 'O')) = True
		| (((tabela !! 6) == 'O') && ((tabela !! 7) == 'O') && ((tabela !! 8) == 'O')) = True
		-- verifica nas colunas
		| (((tabela !! 0) == 'O') && ((tabela !! 3) == 'O') && ((tabela !! 6) == 'O')) = True
		| (((tabela !! 1) == 'O') && ((tabela !! 4) == 'O') && ((tabela !! 7) == 'O')) = True
		| (((tabela !! 2) == 'O') && ((tabela !! 5) == 'O') && ((tabela !! 8) == 'O')) = True
		-- verifica nas diagonais
		| (((tabela !! 0) == 'O') && ((tabela !! 4) == 'O') && ((tabela !! 8) == 'O')) = True
		| (((tabela !! 2) == 'O') && ((tabela !! 4) == 'O') && ((tabela !! 6) == 'O')) = True
		| otherwise = False


-- função que atualiza pontuação do vencedor
-- recebe a lista (Jogadores), o nome do vencedor e retorna uma nova lista atualizada
atualizaPontuacao :: Jogadores -> String -> Jogadores
atualizaPontuacao ((Jogador nome pontuacao):xs) vencedor
				| (nome == vencedor) = [(Jogador nome (pontuacao + 1))] ++ xs
				| otherwise = (Jogador nome pontuacao):(atualizaPontuacao xs vencedor)


-- exibir ranking dos jogadores
-- critério: da maior para a menor pontuação
exibirRanking :: Jogadores -> IO ()
exibirRanking [] = return ()
exibirRanking (x:xs) = do
			putStrLn ((obterNome x) ++ " possui " ++ (show (obterPontuacao x)) ++ " pontos")
			exibirRanking xs


-- função que recebe um jogador e retorna o nome
obterNome :: Jogador -> Nome
obterNome (Jogador nome _) = nome

-- função que recebe um jogador e retorna a pontuação
obterPontuacao :: Jogador -> Pontuacao
obterPontuacao (Jogador _ pontuacao) = pontuacao


-- função que define o critério de ordenação
ordenar :: Jogadores -> Jogadores
ordenar dados = sortBy (compare `on` obterPontuacao) dados