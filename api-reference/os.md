# `os`

Operating System functionality module.

## `exit`

Exits a program with a status code.

```cloe
(def (exit . status 0))
(type (exit number) nil)
```

## `readStdin`

Reads stdin.
When `list` argument is `true`, it returns contents of stdin as a list.

```cloe
(def (readStdin . list false))
(type (readStdin . boolean) (or string list))
```
