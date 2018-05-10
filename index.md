# Cloe programming language

Cloe is the *timeless* functional programming language which provides implicit
parallelism, concurrency, and reactiveness.
It aims to be simple and practical.

The code below is an example of "Hello, world!" HTTP server. As the language is
*timeless*, it can take in and process all HTTP requests from now to the
infinite future as a list at once as if ignoring the concept of time.

```cloe
#!/usr/bin/env cloe

(import "http")

(def (handler request)
  ((request "respond") "Hello, world!"))

(let requests (http.getRequests ":8080"))

..(map handler requests)
```
