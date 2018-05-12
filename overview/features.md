# Features

## Functional programming

Functional programming is a programming pradigm where functions are first-class
values, which means functions can be passed as arguments to other functions.
That allows programmers to express programs by combining functions into
more complex ones.

```cloe
(def (foo func) (func 34))

(def (bar num) (+ num 8))

(write (foo bar)) ; Prints "42" on terminal.
```

In such paradigm, it is encouraged to use pure functions, which have
no side effects as they just compute their results from given arguments but
must not do anything else.
And the counterpart is called impure functions, which have certain side effects.
Therefore, Cloe distinguishes these 2 types of functions in order to prevent
impure functions from being called in context where only pure function calls
are permitted, and vice versa.

## Immutable data

As some other functional programming languages, Cloe prevents variables from
being mutated because that makes programs more predictable and functions easier
to test while they might be redefined shadowing previous ones.

```cloe
(let x ["foo" "baz"])
(let y (insert x 2 "bar"))

(write x) ; -> ["foo" "baz"]
(write y) ; -> ["foo" "bar" "baz"]
```

## Lazy evaluation

Lazy evaluation is a strategy to evaluate and run programs in functional
programming.
In most programming languages, pieces of programs are evaluated in an eager way;
operations there come in order and function calls are evaluated just when
called.
However, in lazy evaluation, calling a function does not mean executing it right
away but stores in memory a pair of the function and its arguments which
may or may not be evaluated into its result later.

Adopting such program evaluation strategy, Cloe gains capability to blend
data which become available at different time.
For instance, Cloe can get incoming HTTP requests which a server receives
from its launch to its termination in a list all at once.
Or, it can express an endless stdin byte stream as an infinite list of bytes
and process it just like other lists using common list manipulation functions,
such as `map` and `reduce`.

## Parallelism & concurrency

Parallelism and concurrency have been complicated challenges in a lot of
programming languages for many years.
Cloe provides implicit parallelism and concurrency while some parts of your
programs may need to be made more parallel manually.
Therefore, programmers do not usually have to care about them as much as other
programming languages.

### Parallelism

Top-level expressions in Cloe are evaluated parallelly, which is how it
parallelizes components of programs automatically.
However, it may not be enough or even excessive.

For that cases, Cloe provides 2 primitive functions of `par` and `seq` with
which you can control parallelism of your programs.
The former `par` evaluates given arguments in parallel while the latter `seq`
does that sequentially.

### Concurrency

When it comes to concurrency, software built on top of Cloe is always
concurrent thanks to its host language, [Go](https://golang.org).

## Reactiveness

Given implicit parallelism, programs written in Cloe are fully reactive.
The output of the following program:

```cloe
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
