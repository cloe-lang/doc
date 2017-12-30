# Coel programming language

Coel is a functional programming language with implicit parallelism and
concurrency.
It aims to be simple, canonical, and practical.

The code below is an example of "Hello, world!" HTTP server.

```coel
#!/usr/bin/env coel

(import "http")

(def (handler request)
  ((request "respond") "Hello, world!"))

(let requests (http.getRequests ":8080"))

..(map handler requests)
```
