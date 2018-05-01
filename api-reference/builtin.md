# `builtin`

Built-in functions and variables.

## General

### `partial`

Applies a function to arguments partially and creates a new function.

```cloe
(def (partial func ..args . ..kwargs))
(type (partial function [any] . dict) function)
```

### `toString`

Converts a value into its string representation.
This function doesn't modify strings.

```cloe
(def (toString arg))
(type (toString any) string)
```

### `dump`

Converts a value into its string representation.
It is similar to `toString` function but converts strings into quoted ones.

```cloe
(def (dump arg))
(type (dump any) string)
```

### `pure`

Treats an impure function call as a pure function call.

```cloe
(def (pure arg))
(type (pure any) any)
```

## Conditionals

### `if`

Takes pairs of a condition and an expression and another expression,
and returns an expression corresponding with the first condition evaluated as
`true` or the last expression if no condition is met.

```cloe
(def (if ..args))
(type (if [any]) any)
```

### `not`

Negates an argument.

```cloe
(def (not arg))
(type (not bool) bool)
```

### `and`

Returns `true` if all arguments are `true`, or `false` otherwise.

```cloe
(def (and ..args))
(type (and [bool]) bool)
```

### `or`

Returns `true` if at least one argument is `true`, or `false` otherwise.

```cloe
(def (or ..args))
(type (or [bool]) bool)
```

## Arithmetic

### `+`, `-`, `*`, `/`

Adds, subtracts, multiplies, or devides numbers.

```cloe
(def (+ ..nums))
(type (+ [number]) number)

(def (- initial ..nums))
(type (- number [number]) number)

(def (* ..nums))
(type (* [number]) number)

(def (/ initial ..nums))
(type (/ number [number]) number)
```

### `//`

Calculates a floor division.

```cloe
(def (// initial ..nums))
(type (// number [number]) number)
```

### `**`

Calculates a power.

```cloe
(def (** first second))
(type (** number number) number)
```

### `mod`

Calculates a modulus.

```cloe
(def (mod first second))
(type (mod number number) number)
```

### `max`, `min`

Returns a maximum or minimum of arguments.

```cloe
(def (max ..args))
(type (max [number]) number)
```

## Comparison

### `=`

Returns `true` if all arguments are equal, or `false` otherwise.
Values of any types except `function` can be compared with this function.

```cloe
(def (= ..args))
(type (= [any]) bool)
```

### `<`, `<=`, `>`, `>=`

Compares arguments and returns `true` if they are ordered properly,
or `false` otherwise.
Their semantics are almost the same as mathematics's
but they can compare not only `number` but also `list` and `string`.

```cloe
(def (< ..args))
(type (< [(or list number string)]) bool)
```

### `ordered?`

Returns `true` if an argument can be compared by ordering functions like `<`,
or `false` otherwise.

```cloe
(def (ordered? arg))
(type (ordered? any) bool)
```

## Collection

### `insert`

Inserts elements into a collection.
For `list` and `string`, `key` argument must be an index of `number`.

```cloe
(def (insert collection ..keyValuePairs))
(type (insert (or dict list string) [any])
  (or dict list string))
```

### `delete`

Deletes an entry from a collection.

```cloe
(def (delete collection elem))
(type (delete (or dict list string) any)
  (or dict list string))
```

### `include`

Checks if a value is included in a collection.

```cloe
(def (include collection elem))
(type (include (or dict list string) any) bool)
```

### `merge`

Merges collections into one.

```cloe
(def (merge collection ..collections))
(type (merge (or dict list string) [(or dict list string)])
  (or dict list string))
```

### `size`

Returns a size of a collection.

```cloe
(def (size collection))
(type (size (or dict list string)) number)
```

### `toList`

Converts a collection into its list representation.

```cloe
(def (toList collection))
(type (toList (or dict list string)) list)
```

## List manipulation

### `first`

Gets a first element in a list.

```cloe
(def (first list))
(type (first list) any)
```

### `rest`

Removes a first element from a list and returns the rest.

```cloe
(def (rest list))
(type (rest list) list)
```

### `map`

Applies a function to each element in a list.

```cloe
(def (map func list))
(type (map function list) list)
```

### `reduce`

Accumulates values with a function which takes 2 arguments.

```cloe
(def (reduce func list))
(type (reduce function list) any)
```

### `filter`

Returns a list of elements which satisfy a condition represented by `func` argument.
`func` argument must be a function which takes an argument and returns `bool`.

```cloe
(def (filter func list))
(type (filter function list) list)
```

### `sort`

Sorts a list.

```cloe
(def (sort list . less <))
(type (sort list . function) list)
```

### `zip`

Returns a list of lists each of which contains elements of the same index
in original lists.

```cloe
(def (zip ..lists))
(type (zip [list]) [list])
```

### `slice`

Slices a list.
Indices are inclusive.

```cloe
(def (slice list))
(type (slice list (start 1) (end nil)) list)
```

### `indexOf`

Finds an element in a list and returns its index.

```cloe
(def (indexOf list elem))
(type (indexOf list any) number)
```

## Typing

### `typeOf`

Returns a type of an argument.

```cloe
(def (typeOf arg))
(type (typeOf any) string)
```

### `bool?`, `dict?`, `function?`, `list?`, `nil?`, `number?`, `string?`

Checks if an argument is the type.

```cloe
(def (bool? arg))
(type (bool? any) bool)
```

## IO

### `read`

Reads stdin or a content of a file.

```cloe
(def (read . file nil))
(type (read (or nil string)) string)
```

### `write`

Writes values to stdout or a file.
It writes to stdout if `file` argument is `1`, stderr if `2`,
or a file if `string`.

```cloe
(def (write ..args . sep " " end "\n" file 1 mode 0664))
(type (write [any] . string string (or number string) number) nil)
```

## Error handling

### `catch`

Catches an error thrown from an expression.

```cloe
(def (catch arg))
(type (catch any) (or {"name" string "message" string} nil))
```

## Parallelism and concurrency

### `par`

Evaluates arguments parallelly and returns the last one.

```cloe
(def (par ..args))
(type (par [any]) any)
```

### `seq`

Evaluates arguments sequentially and returns the last one.

```cloe
(def (seq ..args))
(type (seq [any]) any)
```

### `seq!`

Evaluates impure function calls sequentially and returns the last one.
This function itself is also impure.

```cloe
(def (seq! ..args))
(type (seq! [any]) any)
```

### `rally`

Sorts arguments by time when each of them is evaluated.

```cloe
(def (rally ..args))
(type (rally [any]) [any])
```
