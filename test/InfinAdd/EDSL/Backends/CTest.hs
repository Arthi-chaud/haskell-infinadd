module InfinAdd.EDSL.Backends.CTest (specs) where

import Data.Text (Text)
import InfinAdd (parse, toEDSL)
import InfinAdd.EDSL.Runner (InfinAddBackend (C), run)
import Test.Hspec
import Text.Printf (perror, printf)

specs :: Spec
specs = describe "C Backend" $ do
    describe "Addition" $ do
        describe "Positive numbers" $ do
            itShouldBe "1 + 1" 2
            itShouldBe "1 + 10" 11
            itShouldBe "100000000000000000000 + 1" 100000000000000000001
            itShouldBe "435439435845843984358439 + 5359766785665822182412343254343435433339459569" 5359766785665822182412778693779281277323818008
        describe "Both numbers are negative" $ do
            itShouldBe "-2 + (-3)" (-5)
            itShouldBe "-99 + (-1)" (-100)
            itShouldBe "-807965 + (-34532)" (-842497)
        describe "Left operand is negative" $ do
            itShouldBe "-24 + 1" (-23)
        describe "Right operand is negative" $ do
            itShouldBe "1 + (-24)" (-23)
            itShouldBe "101 + (-99)" 2
            itShouldBe "101 + (-999)" (-898)
            itShouldBe "987143265 + (-876435)" 986266830
    describe "Substraction" $ do
        describe "Positive Numbers" $ do
            describe "Result is positive" $ do
                itShouldBe "3 - 2" 1
                itShouldBe "24 - 10" 14
                itShouldBe "100 - 100" 0
                itShouldBe "435439435845843984358439 - 2" 435439435845843984358437
            describe "Result is negative" $ do
                itShouldBe "2 - 3" (-1)
                itShouldBe "99 - 100" (-1)
        describe "Negative Numbers" $ do
            describe "Left operand is smaller" $ do
                itShouldBe "(-2) - (-3)" 1
                itShouldBe "(-10) - (-300)" 290
                itShouldBe "(-14) - (-5)" (-9)
                itShouldBe "(-1000) - (-1000)" 0
            describe "Right operand is bigger" $ do
                itShouldBe "(-1000) - (-100)" (-900)
                itShouldBe "(-99) - (-1)" (-98)
        describe "Left operand is negative" $ do
            itShouldBe "(-24) - 1" (-25)
            itShouldBe "(-807965) - 10" (-807975)
        describe "Right operand is negative" $ do
            itShouldBe "1 - (-24)" 25
            itShouldBe "10 - (-10)" 20
            itShouldBe "10 - (-99)" 109

itShouldBe :: Text -> Integer -> SpecWith ()
itShouldBe s n = it (printf "%s == %d" s n) $ do
    case parse s of
        Left err -> perror err
        Right expr -> run C (toEDSL expr) >>= (`shouldBe` n)
