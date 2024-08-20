import qualified InfinAdd.Parser.ParserTest as P
import Test.Hspec (hspec)

main :: IO ()
main = hspec $ do
    P.specs
