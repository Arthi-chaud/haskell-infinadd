module InfinAdd.EDSL.Runner (run, InfinAddBackend (..)) where

import Control.Monad.Free (foldFree)
import InfinAdd.EDSL.Backends.Native (runNative)
import InfinAdd.EDSL.EDSL (InfinAdd)

data InfinAddBackend = Native deriving (Eq)

run :: (Monad m) => InfinAddBackend -> InfinAdd a -> m a
run Native = foldFree runNative
