module InfinAdd.Parser.ParserTest (specs) where

import Data.Text
import InfinAdd.Parser.Expression (Expression (Add, Negate, Sub, Value))
import InfinAdd.Parser.Parser
import Test.Hspec

specs :: Spec
specs =
    describe "Parse Expression" $ do
        test
            "1 + 1"
            (Add (Value 1) (Value 1))
        test
            "-1"
            (Negate (Value 1))
        test
            "((1))"
            (Value 1)
        test
            "1 + (2 - 3)"
            (Add (Value 1) (Sub (Value 2) (Value 3)))

test :: Text -> Expression -> Spec
test str expr = it (unpack str) $ parse str `shouldBe` Right expr
