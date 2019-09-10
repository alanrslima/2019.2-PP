import System.IO
-- import Control.Monad
import qualified Data.Text
import Data.List.Split
import Data.Array



readTxtFile  = "Voce deve inserir o nome de um arquivo"
readFileLines file_name = do
        contents <- readFile file_name
        let lines_list = lines contents
        let lines = doWords lines_list
        writeHtml (joinLines lines)

doWords [] = []
doWords list = words (head list): doWords (tail list)


joinLines [] = []
joinLines list =
              ((joinWordsList ( mdParser (head list))))++ joinLines (tail list)

mdParser [] = []
mdParser wordList = if funcao (head wordList) == head wordList
                    then [head wordList]++  mdParser (tail wordList)
                    else (funcao (head wordList): mdParser (tail wordList))++ ["</" ++ (tail (funcao (head wordList)))++ "\n"]

-- Tags para titulo
funcao "#" = "<h1>"
funcao "##" = "<h2>"
funcao "###" = "<h3>"
funcao "####" = "<h4>"
funcao "#####" = "<h5>"
funcao "######" = "<h6>"
-- Texto puro
funcao word = word

joinWordsList [] = " "
joinWordsList list =
              ((head list)++ " ")++ joinWordsList (tail list)


writeHtml txt = do
              arq <- openFile "out.html" WriteMode
              hPutStrLn arq (txt)
              hClose arq;
