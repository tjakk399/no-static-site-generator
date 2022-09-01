---
title: Optimizers
subtitle: Deep Learning Notes
last-update: 03.11.2021
author: David Kaumanns
tags:
  - Machine Learning
  - Deep Learning
---


## First-Order Optimizers

### Fixed First-Order Optimizers

Use fixed learning rate, i.e. a fixed hyper-parameter.

#### Stochastic Gradient Descent


### Adaptive First-Order Optimizers

Problem: How to dampen oscillations in search?
Solution: Adapt current learning rate based on past gradients.

#### Stochastic Gradient Descent with Momentum

Method of adapting learning rate: Adding exponential average of past gradients ("momentum")

Accelerates search in the direction of minima.

$$
\Delta = \eta * \Delta - \alpha *
$$

- $\alpha$: learning rate
- $\delta$: step size
- $\eta$: hyperparameter (coefficient of momentum) = $[0,1]$

#### RMSprop

Method of adapting learning rate: Averaging single gradients by exponential average of squares of past gradients

Impedes search in the direction of oscillations.

Implicitly performs simulated annealing.

$$
\upsilon_t = \rho * \upsilon_{t-1} + (1 - \rho) * g_t^2
$$

$$
\Delta_{w_t} = - \frac{\alpha * g_t}{\sqrt{\upsilon_t + \epsilon}}
$$

- $g_t$: gradient at time $t$ along parameter $w_j$
- $\alpha$: learning rate
- $\Delta$: step size
- $\rho$: hyperparameter = $[0,1]$
- $\epsilon$: small value
- $\upsilon$: exponential moving average


#### Adam

Combines heuristics of Momentum and RMSprop.

$$
\upsilon_t = \beta_1 * \upsilon_{t-1} + (1 - \rho) * g_t^2
$$

$$
\Delta_{w_t} = - \frac{\upsilon_t * \alpha * g_t}{\sqrt{\uspilon_t + \epsilon}}
$$
