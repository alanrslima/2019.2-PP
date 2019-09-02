import System.IO
import Control.Monad


readTxtFile :: [Char] -> IO [Char]
-- readTxtFile " " = return "Voce deve o nome de um arquivo"
readTxtFile file_name = do
        let list = []
        handle <- openFile file_name ReadMode
        contents <- hGetContents handle
        return contents
