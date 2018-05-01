# `json`

JSON encoder and decoder module.

## `encode`

Encodes a value into a JSON string.

```cloe
(def (encode decoded))
(type (encode any) string)
```

## `decode`

Decodes a JSON string into a value.

```cloe
(def (decode encoded))
(type (decode string) any)
```
