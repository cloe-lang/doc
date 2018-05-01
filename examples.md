# Examples

## Hello, world!

```cloe
(write "Hello, world!")
```

## HTTP server

```cloe
(import "http")

..(map
  (\ (request) ((request "respond") "Hello, world!"))
  (http.getRequests ":8080"))
```
