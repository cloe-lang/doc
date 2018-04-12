# Concept

The abstract concept lying under Coel is described here for better understanding
of why the language looks so.

## Modeling programs

Hundreds of models for computer programming have been developed over decades.
The computation models formulated pure computation theoretically while
object-oriented programming has been adopted widely as a way of abstraction.

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

To start modeling a program, let's cut it out from the universe.
Then it is clearly visible that what we focus on are only the program and
the others but nothing else.

```
┌─────────┐
│ program │
└─────────┘
```

The next topic is what programs do and how they behave.
For simplicity, classify the actions done by programs into 2 categories.
One is "inputs" which are pure queries for information towards the outside of
the program.
The other is "effects" which change something else in the universe.

```
   input
     │
┌────▼────┐
│ program │
└────▼────┘
     │
   effect
```

A point to notice is that this is a stateful model and the diagram above
illustrates just a single moment of the program's execution.
The program may change its state every time when it receives an input.

### Stateless models

Now it's time to make the previous model stateless so that we can apply
functional programming for it.
The problem is that the program part is not a pure function because it is
stateful.
It works well to remove states out from the program and make a loop which feeds
back them to the program itself.

```
 input
   │   ┌────┐
┌──▼───▼──┐ │
│ program │ │ state
└──▼───▼──┘ │
   │   └────┘
 effect
```

Then, the loop which passes states around for every input are expanded over
time.

```
initial   input       input       input
 state──┐   │   ┌───┐   │   ┌───┐   │   ┌─
     ┌──▼───▼──┐│┌──▼───▼──┐│┌──▼───▼──┐│
     │ program │││ program │││ program ││ ...
     └──▼───▼──┘│└──▼───▼──┘│└──▼───▼──┘│
        │   └───┘   │   └───┘   │   └───┘
      effect      effect      effect
```

Simplify the diagram by integrating the initial state into the program and
collecting up the inputs and effects.

```
  inputs
     │
┌────▼────┐
│ program │
└────▼────┘
     │
  effects
```

Finally, we obtained the totally stateless and functional model of programs
and this is how programs written in Coel looks.
Composing a program is equivalent to building up a pure function which maps its
inputs to its effects.

## Analysis

### Programs can be lazy

As inputs are just queries to the outside of programs, they do not have to be
evaluated always but only when necessary.

> WIP
