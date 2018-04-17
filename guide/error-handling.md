# Error Handling

## Errors

Errors occurring in some expressions are propagated to top ones and make
whole programs crash.
Errors can be caused in different ways, such as adding non-number values,
joining a string and a list, and passing a wrong number of arguments to a
function.

```coel
(write (+ 1 true)) ; Adding non-number values is invalid.
```

## Throwing errors manually

The built-in `error` function creates an error with its name and message.
It can be used to create and throw custom errors.

```coel
(error "MyError" "me ate sugar")
```

## Catching errors with `catch` function

Because it is sometimes necessary to catch errors and do some retries or cleanups,
Coel has a primitive function named `catch` which cancels error propagations
and returns information of the errors as dictionaries.

```coel
; Prints '{"name" "ValueError" "message" "\"true\" is not a number"}'.
(write (catch (+ 1 true)))
```
