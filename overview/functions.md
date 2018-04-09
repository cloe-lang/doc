# Functions

Functions are essentially mappings of data to data and they can be combined to
create more complex and useful ones.
In other words, they are converters of data; given arguments, they calculate
results.
For the reason that functions are the most fundamental part in Coel, this page
illustrates how to call and define functions in detail.

## Calling functions

### Arguments

#### Positional arguments

> WIP

#### Keyword arguments

> WIP

## Defining functions

There are 2 ways to define functions, `def` statements and anonymous functions.
Although the former is more expressive and common, the latter is convenient
when you want to create one-off functions instantly.

Functions are characterized by their two kinds of components: signatures
which determine how they receive arguments and body expressions which describe
how the arguments are converted into results.

### Signatures

Signatures are sets of parameters which are placeholders of values used in
functions.
There are 2 kinds of parameters, positional and keyword ones.

#### Positional parameters

> WIP

```coel
(def (foo x) x)

(def (bar ..rest) rest)
```

#### Keyword parameters

Keyword parameters are defined with their names and default values.
They must be put after `.` in signatures with the default values like
`. someName "defaultValue"`.
Passed keyword arguments can also be collected into variables using rest
parameters preceded by `..`.

```coel
(def (foo . x 42) x)

(def (bar . ..rest) rest)
```

### `def` statements

> WIP

```coel
(def (foo x y)
  (+ x y))

(def (sum ..args)
  (+ ..args))
```

### Anonymous functions

Anonymous functions are quite useful when you are creating simple functions
which are used only once.
They cannot be recursive because they have no names as the name suggests.

```coel
(\ (x) (+ x 42))
(\ (x ..args . y 42 ..kwargs) (+ x y))
```

### Mutually recursive functions

Because codes in Coel are interpreted from top to bottom, it provides a special
syntax `mr` for creation of mutually recursive functions which refer to each
other inside themselves.
In `mr` clauses, functions are defined in a usual way while they can use other
functions in the clause.

```coel
(mr
  (def (even? n)
    (if (= n 0) true (odd? (- n 1))))
  (def (odd? n)
    (if (= n 0) false (even? (- n 1)))))
```
