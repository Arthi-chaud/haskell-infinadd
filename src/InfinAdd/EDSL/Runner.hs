module InfinAdd.EDSL.Runner (run, InfinAddBackend (..)) where

import Control.Monad.Free (foldFree)
import Control.Monad.IO.Class (MonadIO)
import InfinAdd.EDSL.Backends.Native (runNative)
import InfinAdd.EDSL.EDSL (InfinAdd)
import InfinAdd.EDSL.Backends.C (runC)

data InfinAddBackend = Native | C deriving (Eq)

run :: (MonadIO m) => InfinAddBackend -> InfinAdd a -> m a
run Native = foldFree runNative
run C = foldFree runC
