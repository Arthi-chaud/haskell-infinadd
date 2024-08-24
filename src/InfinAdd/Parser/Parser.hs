module InfinAdd.Parser.Parser (InfinAdd.Parser.Parser.parse) where

import Control.Monad.Combinators.Expr (Operator (InfixL, Prefix), makeExprParser)
import Data.Text
import InfinAdd.Parser.Expression
import Text.Megaparsec
import qualified Text.Megaparsec as M
import Text.Megaparsec.Char (space1)
import qualified Text.Megaparsec.Char.Lexer as L

parse :: Text -> Either String Expression
parse input = case M.parse pExpression "" input of
    Right expr -> Right expr
    Left err -> Left $ show err

type Parser = Parsec String Text

pExpression :: Parser Expression
pExpression = makeExprParser pTerm operatorTable

pTerm :: Parser Expression
pTerm = M.choice [parens pExpression, pNumber]

pNumber :: Parser Expression
pNumber = Value <$> lexeme L.decimal

parens :: Parser Expression -> Parser Expression
parens = between (symbol "(") (symbol ")")

operatorTable :: [[Operator Parser Expression]]
operatorTable =
    [ [prefix "-" Negate, prefix "+" Positive]
    , [binary "+" Add, binary "-" Sub]
    ]

binary :: Text -> (Expression -> Expression -> Expression) -> Operator Parser Expression
binary name f = InfixL (f <$ symbol name)

prefix :: Text -> (Expression -> Expression) -> Operator Parser Expression
prefix name f = Prefix (f <$ symbol name)

symbol :: Text -> Parser Text
symbol = L.symbol sc

lexeme :: Parser a -> Parser a
lexeme = L.lexeme sc

sc :: Parser ()
sc = L.space space1 (L.skipLineComment "//") (L.skipBlockComment "/*" "*/")
