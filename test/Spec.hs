import qualified InfinAdd.EDSL.Backends.NativeTest as N
import qualified InfinAdd.Parser.ParserTest as P
import Test.Hspec (hspec)

main :: IO ()
main = hspec $ do
    P.specs
    N.specs
