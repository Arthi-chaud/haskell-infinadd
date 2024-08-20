module InfinAdd.Parser.Expression (Expression (..)) where

data Expression
    = Value Integer
    | Add Expression Expression
    | Sub Expression Expression
    | Negate Expression
    | Positive Expression
    deriving (Show, Eq)

-- TODO: To EDSL Terms
