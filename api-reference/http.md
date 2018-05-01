# `http`

HTTP module.

## `get`

Sends a GET request to a given URL.
If `error` is `true` and  a status code is not 2xx, it raises an error.

```cloe
(def (get url . error true))
(type (get string . bool)
  {"status" number
   "body" string})
```

## `post`

Sends a POST request to a given URL.
If `error` is `true` and  a status code is not 2xx, it raises an error.

```cloe
(def (post url body . contentType "text/plain" error true))
(type (post string string . string bool)
  {"status" number
   "body"   string})
```

## `getRequests`

Gets incoming HTTP requests as an infinite list.

```cloe
(def (getRequests address))
(type (getRequests string)
  (def (respond body . status 200))
  (type (respond string . number) nil)
  [{"body" string
    "method" string
    "respond" respond
    "url" string}])
```
