# `http`

## `get`

Sends a GET request to a given URL.
If `error` is `true` and  a status code is not 2xx, it raises an error.

```coel
(type (get string . bool)
  {"status" number
   "body" string})
(def (get url . (error true)))
```

## `post`

Sends a POST request to a given URL.
If `error` is `true` and  a status code is not 2xx, it raises an error.

```coel
(type (post string string . string bool)
  {"status" number
   "body"   string})
(def (post url body . (contentType "text/plain") (error true)))
```

## `getRequests`

Get incoming HTTP requests as an infinite list.

```coel
(type (getRequests string)
  (type (respond string . number) (effect nil))
  (def (respond (body "") . (status 200)))
  [{"body" string
    "method" string
    "respond" respond
    "url" string}])
(def (getRequests address))
```
