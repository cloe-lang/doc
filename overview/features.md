# Features

## Functional programming

Functional programming is a programming pradigm where functions are first-class
values, which means functions can be passed as arguments to other functions.
That allows programmers to express programs just by combining functions to make
others.

In such paradigm, it is encouraged to use pure functions, which must not have
any side effects; they just compute their results from given arguments but
cannot do anything else.
And the counterpart is called impure functions, which have some side effects.
Therefore, Coel distinguishes these 2 types of functions in order to prevent
impure function calls in pure context where only pure function calls are
permitted, and vice versa.

```coel
(def (foo func) (func 34))

(def (bar num) (+ num 8))

(write (foo bar)) ; Prints "42" on terminal.
```

## Immutable variables

As some other functional programming languages, Coel prevents variables from
being mutated because that makes programs more predictable and functions easier
to test.
However, variables defined in the programs can be redefined shadowing previous
ones.

```coel
(let x 123)
(let y x)
(let x 456)

(write x y) ; Prints "456 123" on terminal.
```

## Lazy evaluation

Lazy evaluation is the "Call Me Maybe" strategy to evaluate and run programs in
functional programming.
In most programming languages, pieces of programs are evaluated in an eager way;
operations in programs come in order and function calls are evaluated when
called.
However, in lazy evaluation, calling a function does not mean executing it right
away but stores it in memory a chunk of the function and its arguments which
may or may not be evaluated into its result later.

It is necessary for Coel to adopt lazy evaluation because there is no other way
to mix values available at different times.
Otherwise it would express only one-shot programs like utility commands but not
ones which run over time like HTTP servers.

## Parallelism & concurrency

Parallelism and concurrency have been complicated challenges in a lot of
programming languages for many years.
Coel provides implicit parallelism and concurrency while some parts of your
programs may need to be made more parallel manually.
Therefore, programmers do not usually have to care about them as much as other
programming languages.

### Parallelism

Top-level expressions in Coel are evaluated parallelly, which is how it
parallelizes components of programs automatically.
However, it may be not enough or even excessive.

That's why Coel provides 2 primitive functions of `par` and `seq` with which
you can control parallelism of your programs.
The former `par` evaluates given arguments in parallel while the latter `seq`
evaluates them sequentially.

### Concurrency

When it comes to concurrency, programs written in Coel are always concurrent
thanks to its host language, [Go](https://golang.org).

## Reactiveness

Given implicit parallelism, software written in Coel is fully reactive.
The output of the following program:

```coel
(write 123)
(write 456)
```

can be both

```
123
456
```

or

```
456
123
```

as the top-level expressions, `(write 123)` and `(write 456)` are evaluated
at once and their side effects can happen out of order.
