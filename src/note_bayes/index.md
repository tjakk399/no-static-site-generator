---
title: Bayes of Events
tags:
  - Machine Learning
---

WORK IN PROGRESS

Sample space $\Omega$ 

:   Set of all possible outcomes of an experiment.

    An outcome can be as simple as a single data point
    or as complex as a combination of outcomes.

Event $A$

:   Subset of all possible outcomes of an experiment,
    i.e. $A \subset \Omega$.
    
    This definition includes the *singleton event*, 
    i.e. an event with a single possible outcome.

    This definition is *recursive*. 
    An event $P(A)$ can contain other events $P(B)$, $P(C)$, ...,
    with $P(A) \geq P(B) + P(C) + ...$.

    Events of a sample space can overlap.

    If $A = \Omega$ then $P(A) = P(\Omega) = 1$.
    
    Example: 

    The sample space of a dice toss experiment is the set of all possible outcomes $\Omega = {1,2,3,4,5,6}$.
    The event "odd number" is defined by its subset $A = {1,3,5}$ of singleton events ${1}$, ${2}$ and ${3}$.
    If the dice is fair, the probability of "odd number" is $P(A) = \frac{3}{6} =  0.5$.

Random variable $X$

:   A special case of an event that depends on random events.

    In other words, a random variable $X$ is a set of events 
    where each member either is a random event itself 
    or depends on random events.

    The probability distribution of the values of a random variable may be non-random, e.g. Gaussian curve.

    Example:

    The variable "sum of 2 tosses of a fair die" depends on the random singleton event of each fair toss.
    The values of this random variable $X$ are distributed across a probability distribution $P(X)$ by the shape of a Gaussian curve.

Probability distribution $P(X)$

:   A mathematical function that yields the probability $P(x)$ for each value $x$ of a random variable $X$.

Marginal probability distribution (of $A$ w.r.t. $B$)

:   The probability distribution of the subset of random variables $A$
    (from a larger set)
    that is independent of another set of random variables $B$:

    $$
    P(A) = \sum_b^B P(A \cap b)
    $$

    The probability of an event $A$ is the sum over all joint probabilities of $A$ with events $b$ from the set of events $B$.
    The $B$ variable is thus "marginalized" away by the sum.

Chain rule of probability (aka "join probability")

:   $$
    P(A \cap B) = P(A|B)P(B)
    $$ {#eq:joint_prob}

    The probability of events $A$ and $B$ occuring together is 


Conditional probability distribution $P(A|B)$

:   $$
    P(A|B) = \frac{P(A \cap B)}{P(B)}, \text{if} P(B) \neq 0
    $$ {#eq:cond_prob}

    The conditional probability of event $A$ given event $B$ is 
    the probability of both events $A$ and $B$ occurring simultaneously
    divided by the probability of event $B$ alone (a-priory).

### Derivation of Bayes' theorem

In @eq:cond_prob, switch the symbols $A$ and $B$:
 
$$
P(B|A) = \frac{P(A \cap B)}{P(A)}, \text{if} P(A) \neq 0
$$ {#eq:cond_prob_switched}

Solve @eq:cond_prob_switched for $P(A \cap B)$:

$$
P(A \cap B) = P(B|A)P(A)
$$ {#eq:cond_prob_switched_2}

Insert @eq:cond_prob_switched_2 into @eq:cond_prob:

Bayes' theorem

:   $$
    P(A|B) = \frac{P(B|A)P(A)}{P(B)}, \text{if} P(B) \neq 0
    $$

### Application of Bayes' theorem

Bayes' theorem allows the reversal of a conditional probability if certain data is applied.

Assume that the following data is given:

- $P(A)$: A-priori probability of event $A$ in the population.
- $P(B)$: A-priori probability of event $B$ in the population.
- $P(B|A)$: Conditional probability of event $B$ given event $A$.
- Assumption: Event $A$ is independent from event $B$ (*Naive Bayes assumption*).

Then *Bayes' theorem* allows the computation of the reverse conditional probability, i.e. $P(A|B)$.

Example application:

Given:

- $P(A)$: Probability of cancer among a set of patients.
- $P(B)$: Probability of positive tests among the same set of patients.
- $P(B|A)$: Probability of the test to be positive given a verified cancer (derived from empirical studies).
- Assumption: Occurrences of cancer are not related to tests applied. For example, the test itself does not cause or prevent said cancer.

A cancer test turned out positive for a patient.
Then *Bayes' theorem* yields the probability $P(A|B)$ of the patient actually having cancer given this positive test.
