# haskell-infinadd

`haskell-infinadd` is a Haskell library and executable that allow you to add numbers without having to worry about bounds! Just like with `Integer`!

Why though? If the feature already exists, why should we reinvent the wheel? Well, sometimes, it's more about the journey than the destination! The goal of this project is to learn how to use `megaparsec`, the C FFI and learn about Embedded Domain Specific Languages (EDSL) design.

## Examples

```haskell
import InfinAdd

main :: IO ()
main = do
    -- You can use `parse`
    res1 <- parse "((1 + 1) - 10) + (-3)" >>= (run C . toEDSL)
    -- Or use EDSL terms
    res2 <- run C $ do
        a <- add 1 1
        b <- sub a 10
        add b (-3)
    print res1
    print res2
```

## How it works

Our EDSL takes the form of an `InfinAdd a` operation. It is a monad, parameterised by the return type of the operation. (most of the time , `a` should be `Integer`). To run the operation, we use the [`run`](https://arthi-chaud.github.io/haskell-infinadd/InfinAdd.html#v:run) function.

### Backends

A backend provides a way to interpret and execute the commands (`add`, `sub`). Two backends have been implemented for this EDSL:

- C. It uses Haskell's FFI to call C functions, which take the two operands as strings (`char *`). These C functions fill a buffer with the result of the addition/subtraction, as a string.
- Haskell. It is really simple as it only consists of calling (+) and (-). It only exists as a proof that the EDSL can be interpreted in multiple ways.

To choose which backend to use with `run`, you must use an [`InfinAddBackend`](https://arthi-chaud.github.io/haskell-infinadd/InfinAdd.html#t:InfinAddBackend) value, depending on your needs.

### Parsing String to EDSL terms.

The parsing of string expressions (using [`parse`](https://arthi-chaud.github.io/haskell-infinadd/InfinAdd-Parser.html#v:parse)) is not that interesting in itself (aside from the learning purposes). However, it should be noted that the parsing result is an AST, and not EDSL terms. This seemed to be good practice, and breaks the dependency between parsing and the EDSL design. ([`toEDSL`](https://arthi-chaud.github.io/haskell-infinadd/InfinAdd-Parser.html#v:toEDSL) transforms this AST into `InfinAdd Integer`).

## Sources

- Mark Karpov's [extensive tutorial for Megaparsec](https://markkarpov.com/tutorial/megaparsec.html)
- Serokell's [article on Free monads](https://serokell.io/blog/introduction-to-free-monads)
- Nokomprendo's [articles on Free monads](https://nokomprendo.gitlab.io/posts/tuto_084/2022-03-10-fr-README.html)

## History

`infinadd` used to be an Epitech project for first-year students. It would serve as a base for a bigger project named *bistro-matic*. The goal was to parse and handle simple mathematical expressions (addition, subtraction, multiplication and division) of very big numbers (possibly larger than an `int`).

---

[![Haddock](https://img.shields.io/badge/Documentation-Haddock-purple)](https://arthi-chaud.github.io/haskell-infinadd) [![codecov](https://codecov.io/gh/Arthi-chaud/haskell-infinadd/graph/badge.svg?token=4MW939PPE6)](https://codecov.io/gh/Arthi-chaud/haskell-infinadd)
