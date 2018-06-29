# Variables

Variables are references to data in programs.
In spite of that variables imply something able to be changed, they are
constant in Cloe.
In other words, their values can be neither modified nor replaced although they
can be redefined.

## `let` statements

The `let` statements define variables binding given names to expressions.
Only names of variables and functions defined already can be used in their body
expressions otherwise the interpreter crashes printing errors about the
missing names.

```cloe
(let x 42)
(let y (map (\ (x) (* x 2)) [123 456 789]))
(let x "foo") ; You can redefine variables of the same names.
```

## `let` expressions

The `let` expressions work as well as `let` statements although they behave like
expressions.

```cloe
(print
  (let
    x (+ 1 2 3 4 5 6 7 8 9)
    (** x 2)))

(print
  (let
    xs (map (\ (x) (** x 2)) [1 2 3])
    [y z _] xs
    (+ y z ..xs)))
```
