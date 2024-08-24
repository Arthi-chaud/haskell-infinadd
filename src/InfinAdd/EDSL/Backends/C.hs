module InfinAdd.EDSL.Backends.C (runC) where

import Control.Monad.IO.Class (MonadIO (liftIO))
import Foreign (callocBytes, free)
import Foreign.C (CSize (CSize), CString, newCString, peekCString)
import GHC.Num (integerToInt)
import InfinAdd.EDSL.EDSL (InfinAddF (Add, Sub))

foreign import ccall "get_addition_max_len" getAddLen :: CString -> CString -> IO CSize

foreign import ccall "get_substration_max_len" getSubLen :: CString -> CString -> IO CSize

foreign import ccall "add" add :: CString -> CString -> CString -> IO CString

foreign import ccall "sub" sub :: CString -> CString -> CString -> IO CString

runC :: (MonadIO m) => InfinAddF a -> m a
runC (Add a b n) = liftIO $ n <$> runC' a b getAddLen add
runC (Sub a b n) = liftIO $ n <$> runC' a b getSubLen sub

runC' ::
    Integer ->
    Integer ->
    (CString -> CString -> IO CSize) ->
    (CString -> CString -> CString -> IO CString) ->
    IO Integer
runC' a b getLen op = do
    ca <- newCString $ show a
    cb <- newCString $ show b
    bufferLen <- getLen ca cb
    buff <- callocBytes (integerToInt $ fromIntegral bufferLen + 1)
    _ <- op buff ca cb
    res <- peekCString buff
    free buff
    return (read res)
