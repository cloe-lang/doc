---
---

# Contribution Guide

## Prerequisites

Install Go 1.8+ and rake, and then Coel's dependnecies.

```shell
rake install_deps
```

## Testing

- `rake unit_test` runs unit tests. It runs `go test` internally.
- `rake command_test` runs command tests written in
  [Gherkin](https://cucumber.io/docs/reference).
- `rake test` runs both.

## Other utilities

- `rake format` formats all files in Go and Ruby.
- `rake lint` lints all files in Go, Ruby and Markdown.
- `rake clean` cleans up all binaries and temporary files.

For more information, see `rakefile.rb`.
