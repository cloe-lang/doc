---
---

# Contribution Guide

## Preparing environment

Install Go 1.8+ and rake and then Coel's dependnecies.

```shell
rake install_deps
```

## Testing

- `rake unit_test` runs unit tests. It runs `go test` internally.
- `rake command_test` runs command tests written in
  [Gherkin](https://cucumber.io/docs/reference).
- `rake test` runs both.

## Other utility tasks

- `rake format` formats all files including source files in Go and Ruby.
- `rake lint` lints all source files in Go.
- `rake clean` cleans up the repository directory deleting some binaries and
  temporary files generated for tests.

For more information, see rakefile.rb.
