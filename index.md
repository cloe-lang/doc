# Cloe programming language

Cloe is the *timeless* functional programming language which provides implicit
parallelism, concurrency, and reactiveness.
It aims to be simple, canonical, and practical.

The code below is an example of "Hello, world!" HTTP server.

```cloe
#!/usr/bin/env cloe

(import "http")

(def (handler request)
  ((request "respond") "Hello, world!"))

(let requests (http.getRequests ":8080"))

..(map handler requests)
```
