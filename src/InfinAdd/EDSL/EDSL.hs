module InfinAdd.EDSL.EDSL (add, sub, InfinAdd, InfinAddF (..)) where

import Control.Monad.Free (Free, liftF)

data InfinAddF a
    = Add Integer Integer (Integer -> a)
    | Sub Integer Integer (Integer -> a)
    deriving (Functor)

type InfinAdd = Free InfinAddF

add :: Integer -> Integer -> InfinAdd Integer
add a b = liftF $ Add a b id

sub :: Integer -> Integer -> InfinAdd Integer
sub a b = liftF $ Sub a b id
