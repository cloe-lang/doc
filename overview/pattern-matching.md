# Pattern Matching

With pattern matching, programmers can express complicated conditional
expressions in a comprehensive way.
It alleviates the hell of mind-blowing nested `if` conditionals
and provides destructuring of matched values.

## Introduction

`match` expression realizes pattern matching in Coel.
Note that `match` keyword is not a name of a function but a special keyword to
begin writing such expressions.

```coel
(match num
  1 "odd"
  2 "even"
  3 "odd")
```

The result of the expression above depends on the value of `num` as it is
`"odd"` if `num == 1`, `"even"` if `2`, and `"odd"` if `3`.
When no pattern is matched with the given value, the expression throws an
error.

## List patterns

> WIP

## Dictionary patterns

> WIP
