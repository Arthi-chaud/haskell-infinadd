module Main (main) where

import Control.Monad (when)
import Data.Text (pack)
import InfinAdd
import System.Exit (exitSuccess)
import System.IO (hFlush, isEOF, stdout)

main :: IO ()
main = loop

loop :: IO ()
loop = do
    putStr "> " >> hFlush stdout
    stop <- isEOF
    when stop exitSuccess
    line <- getLine
    case parse (pack line) of
        Left err -> putStrLn err >> loop
        Right expr -> do
            number <- run Native (toEDSL expr)
            print number
            loop
