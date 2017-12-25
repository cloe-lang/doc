# Coel programming language

Coel is a functional programming language with implicit parallelism and
concurrency.
It aims to be simple, canonical, and practical.

```coel
(import "http")

(def (handler request)
  ((request "respond") "Hello, world!"))

(let requests (http.getRequests ":8080"))

..(map handler requests)
```
