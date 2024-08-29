module InfinAdd.EDSL.Backends.NativeTest (specs) where

import InfinAdd
import Test.Hspec

specs :: Spec
specs = describe "Native Backend" $ do
    it "Simple Addition" $ test (add 1 1) 2
    it "Simple Substration" $ test (sub 10 1) 9
    it "Addition and subion" $ flip test (-1) $ do
        two <- add 1 1
        sub two 3

test :: InfinAdd Integer -> Integer -> Expectation
test a n = run Native a >>= (`shouldBe` n)
