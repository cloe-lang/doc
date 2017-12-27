# Examples

## Hello, world!

```coel
(write "Hello, world!")
```

## HTTP server

```coel
(import "http")

..(map
  (\ (request) ((request "respond") "Hello, world!"))
  (http.getRequests ":8080"))
```
