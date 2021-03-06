# Types

There are 7 built-in types and no user-defined ones in Cloe.
Its type system is quite similar to one of [JSON](https://json.org) while it
has one extra type of [function](#function).
Cloe is also dynamically typed as types of any expressions are determined at
runtime.

## Boolean

Booleans take 2 kinds of values, `true` or `false`.
They are commonly used to express whether conditions are true or not.

```cloe
true
false
```

## Dictionary

Dictionaries (a.k.a. maps or associated arrays) represent sets of key-value
pairs.
This type of values can express something just like dictionaries
(e.g. mapping of product names to their prices) but also objects.

```cloe
{} ; An empty dictionary
{"key1" 123 "key2" 456}
{"key" value ..anotherDictionary} ; A dictionary can be expanded into another.
{"name" "John" "age" 24 "kind" "turtle"} ; A dictionary representing a user object
```

## Function

Functions are quite similar to ones in mathematics although it can take any
types of values but not only numbers.
Most of them are pure; they do not usually do anything like printing strings on
terminal other than computing their results.

```cloe
(def (foo x) x) ; def statements to define new functions
(\ (x) (+ x 1)) ; Anonymous function expression
(foo 42) ; Calling a function with an argument of a value, 42
```

## List

Lists are sequences of some other values.
Note that lengths of lists can be infinite in some situations due to lazy
evaluation.

```cloe
[1 2 3]
[[1 2 3] [4 5 6] [7 8 9]]
["foo" "bar" "baz"]
[nil true 42 "foo"] ; You can mix different types of elements.
[1 2 ..[3 4]] ; A list can be expanded into another.
```

## Nil

Nil is a type of only one kind of value `nil` implying nonexistence of values
commonly.

```cloe
nil
```

## Number

Numbers are also just like ones in mathematics.
There is no difference between integers and floating point numbers as every
number is represented in
[double-precision floating-point format of IEEE 754](https://en.wikipedia.org/wiki/Double-precision_floating-point_format).

```cloe
0
1
1.5
2
3
42
-1
-42
```

## String

Strings represent sequences of bytes which can be both text and binary data.

```cloe
"foo"
"bar"
"Hello!"
"こんにちは!"
```
