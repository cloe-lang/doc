# Functions

Functions are merely converters of data and probably combined to create more
complex and useful ones.
In other words, they are mappings of data; given arguments, they calculate
results.
For the reason that functions are the most fundamental part in Cloe, this page
illustrates how to call and define them in detail.

## Calling functions

Functions are called with arguments and compute their results depending on
their values.
Besides, function calls are expressions which represent their results.

### Arguments

There are 2 kinds of arguments: required and optional arguments.

#### Required arguments

Required arguments are arguments which fill required parameters of called
functions.
They are passed to functions and consumed from left to right with consideration
of their orders.
Lists can be expanded into required arguments preceded by `..` markers.

```cloe
(someFunction x y)
(someFunction ..[1 2])
```

#### Optional arguments

Optional arguments are the arguments which replace default values of optional
parameters defined in called functions.
To pass such arguments, they must be preceded by `.` specifying
them as optional arguments aligned as key-value pairs.
Dictionaries can be expanded into optional arguments while the keys of the
dictionaries must be all strings.

```cloe
(someFunction . option1 42 option2 "foo")
(someFunction . ..{"option1" 42 "option2" "foo"})
```

## Defining functions

There are 2 ways to define functions, `def` statements and anonymous functions.
Although the former is more expressive and common, the latter is convenient
when you want to create one-off functions instantly.

Functions are characterized mainly by 2 kinds of components: signatures
which determine how they receive arguments and body expressions which describe
how the arguments are converted into results.

### Signatures

Signatures are sets of parameters which are placeholders of values used in
functions.
There are 2 kinds of parameters, required and optional ones.

#### Required parameters

Required parameters are placeholders of required arguments.
They receive and bind given names with the arguments considering their orders.
Passed required arguments can also be collected into list variables using
rest parameters preceded by `..`.

Required parameters are always required.
If no passed arguments can fill any required parameters on function calls,
errors will be raised with appropriate messages about which parameters are
missing.

```cloe
(def (foo x) x)
(def (bar ..rest) rest)
```

#### Optional parameters

Optional parameters are defined with their names and default values.
They must be placed after `.` in signatures with the default values like
`. someName "defaultValue"`.
Passed optional arguments can also be collected into dictionary variables using
rest parameters preceded by `..`.

```cloe
(def (foo . x 42) x)
(def (bar . ..rest) rest)
```

### `def` statements

The most basic way to create functions.
Every `def` statement is composed of a function name, a signature, internal
statements, and body expression.
Interestingly, they can contain other `def` or `let` statements to define
intermediate values which are used in subsequent statements and body
expressions.

```cloe
(def (foo x y)
  (+ x y))

(def (sum ..args)
  (+ ..args))

(def (+all ns ms)
  (def (add ns)
    (let x (ns 1))
    (let y (ns 2))
    (+ x y))
  (let mappedFunction add)
  (map mappedFunction (zip ns ms)))
```

### Anonymous functions

Anonymous functions are quite useful when you are creating simple functions
which are used only once.
The most notable trait of them is that they are not statements but
expressions, which lets you write less and cleaner codes in some occasions.
Needless to say, they cannot be recursive by themselves because they have no
names as the name suggests.

```cloe
(\ (x) (+ x 42))
(\ (x ..args . y 42 ..kwargs) (+ x y))
```

### Mutually recursive functions

Because codes in Cloe are interpreted from top to bottom, it provides a special
syntax `mr` for creation of mutually recursive functions which refer to each
other inside themselves.
In `mr` clauses, functions are defined in a usual way while they can use other
functions in the clause.

```cloe
(mr
  (def (even? n)
    (if (= n 0) true (odd? (- n 1))))
  (def (odd? n)
    (if (= n 0) false (even? (- n 1)))))
```
