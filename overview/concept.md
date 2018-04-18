# Concept

Abstract concepts lying under Coel are described here for better understanding
of why the language looks so.

## Modeling programs

Hundreds of models for computer programming in general have been developed over
decades.
Computation models formulated pure computation theoretically while
object-oriented programming has been adopted widely as a way to construct and
modularize programs.
Although that is one of the most controversial areas, object-oriented
programming and functional programming are 2 representative counterparts in
terms of states of programs as they encourage stateful and stateless
programming styles respectively.

This section reveals stateful and stateless models of programs on which Coel
is based.
The explanation about the former comes first as it is more straightforward and
even natural for us to think about such models and then the latter which is
easier to be fitted to functional programming.

### Stateful models

Before starting to think about programs, we must decide what entities to
discuss.
To begin with, define the universe which comprises everything existing in the
world.

```
(universe)
```

Next let's cut a program out from the universe in order to model it.
Then it is clearly visible that what we focus on are only the program and
the rest but nothing else.

```
+---------+
| program |
+---------+
```

The next topic is how programs interact with the rest in the universe.
For simplicity, classify the actions done by programs into 2 categories.
One is *inputs* which are pure queries for information towards the outside of
the program.
The other is *effects* which change something other than the program itself in
the universe.

```
   input
     |
+----v----+
| program |
+----v----+
     |
   effect
```

A point to notice is that this is a stateful model and the diagram above
illustrates just a single moment of the program's execution.
The program may change its state every time when it receives an input.

### Stateless models

Now it's time to make the previous model stateless so that we can apply
functional programming for it.
The problem is that the program part is not a pure function because having a
state.
It works well to remove the state out from the program and make a loop which
feeds back the state to the program itself.

```
 input
   |   +----+
+--v---v--+ |
| program | | state
+--v---v--+ |
   |   +----+
 effect
```

Then, the loop which passes states around for every input is expanded over
time.

```
            input        input        input
              |            |            |
initial  +----v----+  +----v----+  +----v----+
 state --> program >--> program >--> program >-- ...
         +----v----+  +----v----+  +----v----+
              |            |            |
            effect       effect       effect
```

Simplify the diagram by integrating the initial state into the program and
collecting up the inputs and effects.

```
  inputs
     |
+----v----+
| program |
+----v----+
     |
  effects
```

Finally, we obtain the totally stateless and functional model of programs and
this is how programs written in Coel look.
Composing a program is equivalent to doing a pure function which maps its
inputs to its effects.

## Analysis

### Programs can be lazy

As inputs are just queries to the outside of programs, they do not have to be
evaluated always but only when necessary.
What we want is only the way to gurantee that all effects are run eventually
before programs finish.

### Reactiveness is easy

The model shows us that implicit reactiveness of programs is exactly as same as
evaluating effects all at once eagerly.
As a result, programs will work in maximum reactiveness as far as computers can.

### Inputs and effects are infinite in general

If sticking to the model, we need some way to express and handle infinite
number of inputs and effects although available memory is limited.
This problem is resolved by lazy evaluation and tail recursion as the former
has function calls be evaluated later and the latter enables infinite
recursive function calls.

### No data race

There is no corrupted data race in the model because access to the same data
occurs only on evaluation of the same function calls demanded by several
different expressions and it can be guarded by common exclusive locks.

## Caveats

### Parallelism is not free

Although concurrency can be implemented in quite effecient ways, implicit
massive parallelism costs a lot on multi-core CPU machines.
For instance, when a myriad of threads are spawned, programs will suffer from
cache incoherence and huge memory usage, and slow down.

Therefore, Coel's approach is to parallelize every side effect but
leave anything else sequential so that users have options whether they run
the computation in parallel or not.
Moreover it provides a primitive function to sequentialize evaluation of
expressions because side effects sometimes need to be run in a sequential
order.

### Observing results of effects

One missing point in the model is how to observe results of effects.
For instance, we may want to check if contents of a file are valid after
they have been written.

Coel has a function to purify the result values of impure function calls in
cases where they have to be refered by other expressions for retries, error
recovery, etc.

### Lack of nondeterminism

As programs are just deterministic functions, the model lacks nondeterminism
especially associated with parallelism which are injected naturally in other
programming languages.
This issue is not investigated thoroughly but an obvious problem caused by it
is that we cannot sort data by times at which they become available.
Moreover, while such sorting is realized easily by concurrent queues in other
languages, Coel cannot adopt it because they are mutable data structures.
A solution which is implemented and available currently is to provide a
function to sort data by times as a built-in feature.
