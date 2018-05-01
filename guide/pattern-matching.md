# Pattern Matching

With pattern matching, programmers can express perplexing conditional
expressions in a comprehensive way.
It alleviates the hell of mind-blowing nested `if` conditionals
and provides destructuring of matched values.

## Introduction

The `match` expressions realize pattern matching in Cloe.
Note that `match` keyword is not a name of a function but a special keyword to
begin writing such expressions.

```cloe
(match someNumber
  1 "odd"
  2 "even"
  3 "odd")
```

The result of the expression above depends on the value of `num` as it will be
`"odd"` if `num == 1`, `"even"` if `2`, and `"odd"` if `3`.
When no patterns are matched with the given values, the expressions throw
errors.

## Wildcard patterns

When you need to capture some values which can take any kinds of values in
match expressions, wildcard patterns would help you.
These patterns bind matched values to given names so that they can be used in
the corresponding expressions.

```cloe
(match someString
  "foo" "Yes!"
  "bar" "OK!"
  x     (merge "No way, " x "..."))
```

## List patterns

Lists can be also matched in match expressions while there are some extra stuff.
Firstly, you can use wildcard patterns inside list patterns to capture their
elements.
And that rule is applied in a recursive way as you can capture even elements
in a list in another list.
Secondly, there is another kind of pattern preceded by `..` with which you can
put remaining elements in a list together into a variable.

```cloe
(match someList
  []                        "Empty!"
  [1 2 3]                   "1, 2, and 3!"
  [x y z]                   (+ x y z)
  ["foo" "bar" ..rest]      rest
  [[1 2 3] [4 5 6] [7 8 x]] (merge (toString x) " should be 9."))
```

## Dictionary patterns

Dictionary patterns are quite similar to list patterns as they can be combined
with wildcard and rest patterns.
However, there is a catch that dictionary keys are not allowed to be wildcard
patterns but only values.

```cloe
(match someDictionary
  {}                          "Empty!"
  {"foo" 1 "bar" 2}           "Foo!"
  {"dividend" x "divisor" y}  (/ x y)
  {"foo" 42 "bar" nil ..rest} rest)
```
