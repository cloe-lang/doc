# Concept

Abstract concepts lying under Cloe are described here for better understanding
of why the language looks so.

## Modeling programs

Hundreds of models for computer programming in general have been proposed over
decades.
Computation models formulated pure computation theoretically while
object-oriented programming has been adopted widely as a way to construct and
modularize programs.
Although that is one of the most controversial areas, object-oriented
programming and functional programming are 2 representative counterparts in
terms of states of programs as they encourage stateful and stateless
programming styles respectively.

This section reveals stateful and stateless models of programs on which Cloe
is based.
The explanation about the former comes first as it is more straightforward and
even natural for us to think about such models and then the latter which is
easier to be fitted to functional programming.

### Stateful models: programs as objects

Before starting to think about programs, we must decide what entities to
discuss.
To begin with, define the universe which comprises everything existing in the
world.

```
(universe)
```

Next let's cut a program out from the universe in order to model it.
Then it is clearly visible that what we have to focus on are only the program
and the rest but nothing else.
The rest includes anything except the program like files, application users,
pizzas in Chicago, and even other programs.

```
+---------+
| program |
+---------+
```

The next topic is how programs interact with the rest in the universe.
For simplicity, we classify the actions done by programs into 2 categories.
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

### Stateless models: programs as functions

It is time to make the previous model stateless so that we can apply
functional programming for it.
The problem is that the program part is not a pure function because having a
state.
If that is the case, it works well to take the state out from the program and
make a loop which feeds back the state to the program itself.
Now remarkably the program is just a function which takes in inputs and
previous states as producing outputs and next states.

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

We simplify the diagram by integrating the initial state into the program and
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
this is how programs written in Cloe look.
Composing a program is equivalent to doing a pure function which maps its
inputs to its effects.

## Analysis

### Programs can be lazy

As inputs are just queries to the outside of programs, they do not have to be
evaluated always but only when necessary.
What we want is only the way to guarantee that all effects are run eventually
before programs finish.

### Reactiveness without theory

The model shows us that potential reactiveness of programs is elicited exactly
by starting executing all effects at once eagerly.
As a result, programs will work in maximum reactiveness as far as computers can.

### Inputs and effects are infinite in general

If sticking to the model, we need some way to express and handle infinite
number of inputs and effects although available memory is limited.
This problem is resolved by lazy evaluation and tail recursion as the former
allows function calls to be evaluated only if that is necessary and the latter
enables infinitely recursive function calls.

### No data race

No corrupted data race happens in the model because simultaneous access to the
same data occurs only on evaluation of the same function calls demanded by
several different expressions and it can be guarded by common exclusive locks.

## Caveats

### Parallelism is not free

Although concurrency can be implemented in quite efficient ways, implicit
massive parallelism costs a lot on multi-core CPU machines.
For instance, when a myriad of threads are spawned, programs will suffer from
cache incoherence and huge memory usage, and slow down.

Therefore, Cloe's approach is to parallelize every effect for reactiveness
but leave anything else sequential so that users have options of whether they
run the computation in parallel or not.
Meanwhile, it provides a primitive function to sequentialize evaluation of
expressions because effects sometimes need to be run serially.

### Observing results of effects

One missing point in the model is how to observe results of effects.
For instance, we may want to check if contents of a file are valid after it has
been written.

Cloe has a function to purify the result values of impure function calls in
cases where they have to be referred by other expressions for retries, error
recovery, etc.

### Lack of nondeterminism

As programs are just deterministic functions, the model lacks nondeterminism
especially associated with parallelism which are injected intrinsically in
other programming languages.
This issue is not investigated thoroughly but an obvious problem caused by it
is that we cannot sort data by time at which they become available.
Moreover, while such sorting is realized easily by something like concurrent
queues in other languages, Cloe cannot adopt it because they are mutable data
structures.
A solution which is implemented and available currently is to provide a
function to do such sorting as a built-in feature.
