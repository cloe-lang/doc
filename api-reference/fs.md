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

## `readFile`

Reads a file.

```cloe
(def (readFile file))
(type (readFile string) string)
```

## `remove`

Removes a file or directory.

```cloe
(def (remove name))
(type (remove string) nil)
```

## `writeFile`

Writes a file.

```cloe
(def (writeFile file content . mode 0600))
(type (writeFile string string . number) nil)
```
