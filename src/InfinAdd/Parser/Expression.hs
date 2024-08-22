module InfinAdd.Parser.Expression (Expression (..), toEDSL) where

import InfinAdd.EDSL.EDSL (InfinAdd, add, substract)

data Expression
    = Value Integer
    | Add Expression Expression
    | Sub Expression Expression
    | Negate Expression
    | Positive Expression
    deriving (Show, Eq)

toEDSL :: Expression -> InfinAdd Integer
toEDSL (Positive n) = toEDSL n
toEDSL (Negate n) = (* (-1)) <$> toEDSL n
toEDSL (Value n) = return n
toEDSL (Add ea eb) = do
    a <- toEDSL ea
    b <- toEDSL eb
    add a b
toEDSL (Sub ea eb) = do
    a <- toEDSL ea
    b <- toEDSL eb
    substract a b
