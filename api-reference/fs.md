# `fs`

File system module.

## `createDirectory`

Creates a directory.

```cloe
(def (createDirectory name))
(type (createDirectory string) nil)
```

## `readDirectory`

Reads a directory and lists up contents.

```cloe
(def (readDirectory name))
(type (readDirectory string) [string])
```

## `remove`

Removes a file or directory.

```cloe
(def (remove name))
(type (remove string) nil)
```
