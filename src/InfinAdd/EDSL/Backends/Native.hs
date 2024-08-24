module InfinAdd.EDSL.Backends.Native (runNative) where

import Control.Monad.IO.Class (MonadIO)
import InfinAdd.EDSL.EDSL

runNative :: (MonadIO m) => InfinAddF a -> m a
runNative (Add a b n) = return $ n (a + b)
runNative (Sub a b n) = return $ n (a - b)
