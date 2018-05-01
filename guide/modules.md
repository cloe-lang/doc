# Modules

To split programs into meaningful units of components, Cloe provides a modules
system.
Modules are basically small parts of programs which are separated into files
and imported by other modules.

There are 2 kinds of modules in the language: main modules and submodules.
Seen from a distance, programs in Cloe are trees consisting of main modules on
top and subtrees of submodules under them.

## Statements

Each module consists of multiple statements which are supposed to define
variables and functions, and even import other modules.

### `import` statements

Used in a module, `import` statements make variables and functions in other
modules available inside the module with their prefices.

```cloe
(import "http") ; import a built-in module
(import "./some_module") ; import a local module

; Now you can use members of the imported modules.
(let requests (http.getRequests ":80"))
```

### `let` statements

Refer to [variables](variables).

### `def` and `mr` statements

Refer to [functions](functions).

## Main modules

Main modules are where side effects of programs are defined as top-level
expressions in addition to statements.
Note that only one main module exists per program while multiple submodules can
be in a program.

### Top-level expressions

Expressions with side effects like printing text on terminal or sending HTTP
responses must be defined at the top level of main modules and these are called
top-level expressions.

```cloe
(write "Hello, world!")
```

## Submodules

Submodules are modules which are imported by other ones including both main
modules and submodules.
Compared with main modules, top-level expressions cannot be used in submodules
while statements can be as well.
