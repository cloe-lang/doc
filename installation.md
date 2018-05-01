# Installation

After installing Go 1.8+, get the Cloe interpreter.

```shell
go get github.com/cloe-lang/cloe/...
```

To test the installation, write a file `main.cloe` of the content:

```cloe
#!/usr/bin/env cloe

(write "Hello, world!")
```

Finally, run the `cloe` command.

```
cloe main.cloe
```

You will see its output like:

```
Hello, world!
```
