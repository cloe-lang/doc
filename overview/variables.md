# Variables

Variables are references to data in programs.
In spite of that variables imply something able to vary, they are constant in
Coel.
In other words, their values can be neither modified nor replaced although they
can be redefined.

## `let` statements

The statements define variables binding given names to expressions.
Only names of variables and functions defined already can be used in the body
expressions otherwise the interpreter crashes printing an error about the
missing name.

```coel
(let x 42)
(let y (map (\ (x) (* x 2)) [123 456 789]))
(let x "foo") ; You can redefine variables of the same names.
```
