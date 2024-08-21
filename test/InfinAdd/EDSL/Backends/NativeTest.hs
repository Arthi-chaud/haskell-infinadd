module InfinAdd.EDSL.Backends.NativeTest (specs) where

import Data.Functor.Identity (Identity)
import InfinAdd.EDSL.EDSL (InfinAdd, add, substract)
import InfinAdd.EDSL.Runner (InfinAddBackend (Native), run)
import Test.Hspec

specs :: Spec
specs = describe "Native Backend" $ do
    it "Simple Addition" $ test (add 1 1) 2
    it "Simple Substration" $ test (substract 10 1) 9
    it "Addition and substraction" $ flip test (-1) $ do
        two <- add 1 1
        substract two 3

test :: InfinAdd Integer -> Integer -> Expectation
test a n = run Native a `shouldBe` (return n :: Identity Integer)
