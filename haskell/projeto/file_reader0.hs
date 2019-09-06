import System.IO
import Control.Monad
import qualified Data.Text
import Data.List.Split
import Data.Array



-- readTxtFile :: [Char] -> String
-- readTxtFile " " = return "Voce deve o nome de um arquivo"
readFileLines file_name = do
        contents <- readFile file_name
        let h = lines contents
        let a = head h
        -- let b = splitOn " " line
        let b = show a
        return b


mdHtmlParser line = do

        -- let a = show line
        let plited = splitOn " " line

        return plited

--        let first = head head plited

--        let  n_word = if first == "##"
--                then "<html>"
--                else first

--        print n_word
