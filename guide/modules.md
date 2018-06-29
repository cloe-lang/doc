# Modules

To split programs into meaningful units of components, Cloe provides a modules
system.
Modules are basically small parts of programs which are separated into files
and imported by other modules.

There are 2 kinds of modules: main modules and submodules.
Seen from a distance, programs in Cloe are trees consisting of main modules on
top and subtrees of submodules under them.

## Statements

Every module consists of multiple statements which are supposed to define
variables or functions, or even import other modules.

### `import` statements

Used in modules, `import` statements make variables and functions belonging to
other modules available there with their prefices.

```cloe
(import "http") ; import a built-in module
(import "./dir/some_module") ; import a local module (the actual filename is ./dir/some_module.cloe)

; Now you can use members of the imported modules.
(let requests (http.getRequests ":8080"))
(print (some_module.some_function 42))
```

### `let` statements

Refer to [variables](variables).

### `def` and `mr` statements

Refer to [functions](functions).

## Main modules

Main modules are where side effects of programs are defined as top-level
expressions in addition to the statements.
Note that only one main module exists per program while a program can contain
multiple submodules.

### Top-level expressions

Expressions with side effects like printing text on terminal or sending HTTP
responses must be defined at the top level of main modules and these are called
top-level expressions when they must be guaranteed to be evaluated on execution
of the programs.

```cloe
(print "Hello, world!")
```

## Submodules

Submodules are modules imported by other ones which can be both main modules or
submodules.
In contrast to main modules, top-level expressions cannot be used in submodules
while the other statements can be as well.
