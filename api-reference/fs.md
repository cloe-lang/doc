# `fs`

File system module.

## `createDirectory`

Create a directory.

```cloe
(def (createDirectory name))
(type (createDirectory string) nil)
```

## `readDirectory`

Read a directory and list up contents.

```cloe
(def (readDirectory name))
(type (readDirectory string) [string])
```

## `remove`

Remove a file or directory.

```cloe
(def (remove name))
(type (remove string) nil)
```
