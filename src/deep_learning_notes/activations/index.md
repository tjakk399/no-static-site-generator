---
title: Layer Activations
subtitle: Deep Learning Notes
last-update: 03.11.2021
author: David Kaumanns
tags:
  - Machine Learning
  - Deep Learning
---

The technicalities of activation functions ist pretty well covered here: <https://en.wikipedia.org/wiki/Activation_function#Comparison_of_activation_functions>

I will add some personal notes here.

Note: The choice of layer activation conditions the initialization schema of network parameters.

<!-- Partial derivative, e.g. \d u x -->
\newcommand{\pd}[2]{\frac{\partial{#1}}{\partial{#2}}}
<!-- Partial derivative, e.g. \pdd 2 u x -->
\newcommand{\pdd}[3]{\frac{\partial^#1{#2}}{\partial{#3}^#1}}
<!-- Mixed derivative, e.g. \pdm 5y 2x 3t -->
\newcommand{\pdm}[6]{\frac{\partial^#1{#2}}{\partial{#4}^#3 \partial{#6}^#5}}

## Sigmoid (Logistic) {#sec:sigmoid}

$$
\sigma(x) = \frac{e^x}{1 + e^x} = \frac{1}{1 + e^{-x}}
$$

$$
\pd{\sigma}{x}(x) = \sigma(x)(1 - \sigma(x))
$$

- $x \in \mathbb{R}$: unit

Properties;

- $\sigma(x) \in ]0, 1[$
- $\sigma(0) = 0.5$
- Small derivatives at extremes

## TanH (Hyperbolic Tangent)

$$
\sigma(x) = \frac{e^x - e^{-x}}{e^x + e^{-x}}
$$

$$
\pd{\sigma}{x}(x) = 1 - \sigma(x)^2
$$

- $x \in \mathbb{R}$: unit

Notes:

- $\sigma(x) \in ]-1, 1[$
- $\sigma(0) = 0$
- Small derivatives at extremes

## ReLU (Rectified Linear Unit)

$$
\sigma(x) = \max{(0, x)}
$$

$$
\pd{\sigma}{x}(x) = \begin{cases}
0         & \text{if } x \lt 0 \\
1         & \text{if } x \gt 0 \\
undefined & \text{if } x = 0
\end{cases}
$$

- $x \in \mathbb{R}$: unit

Notes:

- $\sigma(x) \in [0, \infty[$
- $\sigma(0) = 0$
- "Dead derivative" at 0 and below
- Allows switching units off completely.

## Softmax

$$
\sigma(x_i) = \frac{e^{x_i}}{\sum_{j=1}^C e^{x_j}}
$$

$$
\pd{\sigma}{x_j}(x_i) = \sigma(x_i)(\delta_{ij} - \sigma(x_j))
$$

- $x_i \in \mathbb{R}$: unit of current layer
- $x_j \in \mathbb{R}$: unit of previous layer
- $\delta_{ij}}$: Kronecker delta
- $C$: number of classes

Notes:

- $\sigma(x) \in [0, 1]$
- Sum of neurons in the same layer is 1.

