module InfinAdd.EDSL.Backends.Native (runNative) where

import InfinAdd.EDSL.EDSL

runNative :: (Monad m) => InfinAddF a -> m a
runNative (Add a b n) = return $ n (a + b)
runNative (Sub a b n) = return $ n (a - b)
