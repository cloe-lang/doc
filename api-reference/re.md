# `re`

Regular Expression (RE) module. Its syntax is the same as
[one of Go language](https://golang.org/pkg/regexp/syntax/).

## `match`

Matches a string with a pattern, and returns `true` if matched or `false`
otherwise.

```coel
(def (match pattern src))
(type (match string string)
  bool)
```

## `find`

Finds the first occurrence of a pattern and its subpatterns in a string.
Each element in a returned list corresponds with strings matched with the
pattern and subpatterns.
It will be `nil` if not matched.

```coel
(def (find pattern src))
(type (find string string)
  [(or string nil)])
```

## `replace`

Replaces all occurrences of a pattern in a string with another string.

```coel
(def (replace pattern repl src))
(type (replace string string string)
  string)
```
