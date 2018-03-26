# `builtin`

Built-in functions and variables.

## General

### `partial`

Applies a function to arguments partially and creates a new function.

```coel
(def (partial func ..args . ..kwargs))
(type (partial function [any] . dict) function)
```

### `toString`

Converts a value into its string representation.
This function doesn't modify strings.

```coel
(def (toString arg))
(type (toString any) string)
```

### `dump`

Converts a value into its string representation.
It is similar to `toString` function but converts strings into quoted ones.

```coel
(def (dump arg))
(type (dump any) string)
```

### `pure`

Treats an impure function call as a pure function call.

```coel
(def (pure arg))
(type (pure any) any)
```

## Conditionals

### `if`

Takes pairs of a condition and an expression and another expression,
and returns an expression corresponding with the first condition evaluated as
`true` or the last expression if no condition is met.

```coel
(def (if ..args))
(type (if [any]) any)
```

### `not`

Negates an argument.

```coel
(def (not arg))
(type (not bool) bool)
```

### `and`

Returns `true` if all arguments are `true`, or `false` otherwise.

```coel
(def (and ..args))
(type (and [bool]) bool)
```

### `or`

Returns `true` if at least one argument is `true`, or `false` otherwise.

```coel
(def (or ..args))
(type (or [bool]) bool)
```

## Arithmetic

### `+`, `-`, `*`, `/`

Adds, subtracts, multiplies, or devides numbers.

```coel
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

```coel
(def (// initial ..nums))
(type (// number [number]) number)
```

### `**`

Calculates a power.

```coel
(def (** first second))
(type (** number number) number)
```

### `mod`

Calculates a modulus.

```coel
(def (mod first second))
(type (mod number number) number)
```

### `max`, `min`

Returns a maximum or minimum of arguments.

```coel
(def (max ..args))
(type (max [number]) number)
```

## Comparison

### `=`

Returns `true` if all arguments are equal, or `false` otherwise.
Values of any types except `function` can be compared with this function.

```coel
(def (= ..args))
(type (= [any]) bool)
```

### `<`, `<=`, `>`, `>=`

Compares arguments and returns `true` if they are ordered properly,
or `false` otherwise.
Their semantics are almost the same as mathematics's
but they can compare not only `number` but also `list` and `string`.

```coel
(def (< ..args))
(type (< [(or list number string)]) bool)
```

### `ordered?`

Returns `true` if an argument can be compared by ordering functions like `<`,
or `false` otherwise.

```coel
(def (ordered? arg))
(type (ordered? any) bool)
```

## Collection

### `insert`

Inserts elements into a collection.
For `list` and `string`, `key` argument must be an index of `number`.

```coel
(def (insert collection ..keyValuePairs))
(type (insert (or dict list string) [any])
  (or dict list string))
```

### `delete`

Deletes an entry from a collection.

```coel
(def (delete collection elem))
(type (delete (or dict list string) any)
  (or dict list string))
```

### `include`

Checks if a value is included in a collection.

```coel
(def (include collection elem))
(type (include (or dict list string) any) bool)
```

### `merge`

Merges collections into one.

```coel
(def (merge collection ..collections))
(type (merge (or dict list string) [(or dict list string)])
  (or dict list string))
```

### `size`

Returns a size of a collection.

```coel
(def (size collection))
(type (size (or dict list string)) number)
```

### `toList`

Converts a collection into its list representation.

```coel
(def (toList collection))
(type (toList (or dict list string)) list)
```

## List manipulation

### `first`

Gets a first element in a list.

```coel
(def (first list))
(type (first list) any)
```

### `rest`

Removes a first element from a list and returns the rest.

```coel
(def (rest list))
(type (rest list) list)
```

### `map`

Applies a function to each element in a list.

```coel
(def (map func list))
(type (map function list) list)
```

### `reduce`

Accumulates values with a function which takes 2 arguments.

```coel
(def (reduce func list))
(type (reduce function list) any)
```

### `filter`

Returns a list of elements which satisfy a condition represented by `func` argument.
`func` argument must be a function which takes an argument and returns `bool`.

```coel
(def (filter func list))
(type (filter function list) list)
```

### `sort`

Sorts a list.

```coel
(def (sort list . less <))
(type (sort list . function) list)
```

### `zip`

Returns a list of lists each of which contains elements of the same index
in original lists.

```coel
(def (zip ..lists))
(type (zip [list]) [list])
```

### `slice`

Slices a list.
Indices are inclusive.

```coel
(def (slice list))
(type (slice list (start 1) (end nil)) list)
```

### `indexOf`

Finds an element in a list and returns its index.

```coel
(def (indexOf list elem))
(type (indexOf list any) number)
```

## Typing

### `typeOf`

Returns a type of an argument.

```coel
(def (typeOf arg))
(type (typeOf any) string)
```

### `bool?`, `dict?`, `function?`, `list?`, `nil?`, `number?`, `string?`

Checks if an argument is the type.

```coel
(def (bool? arg))
(type (bool? any) bool)
```

## IO

### `read`

Reads stdin or a content of a file.

```coel
(def (read . file nil))
(type (read (or nil string)) string)
```

### `write`

Writes values to stdout or a file.
It writes to stdout if `file` argument is `1`, stderr if `2`,
or a file if `string`.

```coel
(def (write ..args . sep " " end "\n" file 1 mode 0664))
(type (write [any] . string string (or number string) number) nil)
```

## Error handling

### `catch`

Catches an error thrown from an expression.

```coel
(def (catch arg))
(type (catch any) (or {"name" string "message" string} nil))
```

## Parallelism and concurrency

### `par`

Evaluates arguments parallelly and returns the last one.

```coel
(def (par ..args))
(type (par [any]) any)
```

### `seq`

Evaluates arguments sequentially and returns the last one.

```coel
(def (seq ..args))
(type (seq [any]) any)
```

### `seq!`

Evaluates impure function calls sequentially and returns the last one.
This function itself is also impure.

```coel
(def (seq! ..args))
(type (seq! [any]) any)
```

### `rally`

Sorts arguments by time when each of them is evaluated.

```coel
(def (rally ..args))
(type (rally [any]) [any])
```
