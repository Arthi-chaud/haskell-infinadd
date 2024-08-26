module InfinAdd.EDSL.Backends.CTest (specs) where

import InfinAdd.EDSL.EDSL (InfinAdd, add)
import InfinAdd.EDSL.Runner (InfinAddBackend (C), run)
import Test.Hspec

specs :: Spec
specs = describe "C Backend" $ do
    describe "Addition (Positive Numbers)" $ do
        it "Simple Addition" $ test (add 1 1) 2
        it "Other Simple Addition" $ test (add 1 10) 11
        it "Big Addition with one big number" $ test (add 1000000000000000000 1) 1000000000000000001
        it "Big Addition with big numbers" $ test (add 122345574728797979 2938797967657517) 125284372696455496
test :: InfinAdd Integer -> Integer -> Expectation
test a n = run C a >>= (`shouldBe` n)
