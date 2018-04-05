# Installation

After installing Go 1.8+, get the Coel interpreter.

```shell
go get github.com/coel-lang/coel/...
```

Then, write a file `main.coel` of the content:

```coel
#!/usr/bin/env coel

(write "Hello, world!")
```

Finally, run the `coel` command.

```
coel main.coel
```

You will see its output like:

```
Hello, world!
```
