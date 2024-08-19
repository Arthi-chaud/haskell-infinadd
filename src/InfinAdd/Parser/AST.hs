module InfinAdd.Parser.AST (Expression (..)) where

data Expression
    = Value String -- TODO Parameterise Expression so that it is parameterised with IsString a
    | Add Expression Expression
    | Sub Expression Expression
    | Negate Expression
    | Positive Expression
    | Par Expression

-- TODO: To EDSL Terms
