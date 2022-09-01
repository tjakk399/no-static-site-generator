---
title: Patterns of Industrial Strength Logic -- DRAFT
tags:
	- Minimal Computing
---

WORK IN PROGRESS

## Definitions

Logic unit

:	A self-contained function with a certain input-output interface, some behaviour (e.g. some stateful behaviour on repeated calls) and possibly some side-effects.

	This definition is recursive. A network of logic units is itself a logic unit.

	On a higher level, a network of logic units is also called a **program**.

	Logic units are specified via a **code grammar** (aka “programming language”) 
	that is translated into low-level machine instructions by a **compiler**.

Logic pattern

:	A set of constraints on a logical unit in terms of its interfaces, inner workings, behaviour and side-effects.
	A logical unit is said to adhere to a logic pattern 
	if and only if 
	the logical unit satisfies all constraints of the logic pattern.

	A logical unit can adhere to more than one logic pattern.
	Not all combinations of logic patterns are possible.
	and some logic patterns are mutually dependent.
	For instance, Memoization requires Statelessness.

	Some logic patterns require a certain logic paradigm (or are useless otherwise).

	Some logic patterns can be implemented independent from the logic paradigm.

	Some logic patterns are dangerous, ill-advised or simply a bad idea in general and should not be implemented.

	Some logic patterns are enforced, prohibited, made easy or made difficult by a specific code grammar.
	E.g. Haskell enforces Statelessness and Python makes Memoization difficult.

Logic paradigm

:	A set of constraints on a logic pattern (i.e. a meta-pattern of logic).

	A logic pattern is said to adhere to a logic paradigm
	if and only if
	the logic pattern satisfies all constrains of the logic paradigm.

## Logic Patterns

The question "which programming languages do you know?"
should be rephrased as "which logic patterns do you know?"

Different logic patterns are suitable for different purposes.

- Currying
- Meta-programming
- Makros
- Templates
- Monads
- Lazyness
- Memoization
- Singleton
- Concurrency
- Statelessness
- Type-Based Constraints
- Pipelines
- ...

## Logic Paradigms

- Object-oriented programming
- Functional programming
- Declarative programming
- Imperative programming
- ...