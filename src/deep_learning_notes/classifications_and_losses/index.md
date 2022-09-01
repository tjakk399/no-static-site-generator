---
title: Classifications and Losses
subtitle: Deep Learning Notes
last-update: 09.11.2021
author: David Kaumanns
tags:
  - Machine Learning
  - Deep Learning
---


## Classifications

--------------------------------------------------------------------------------------------------
                      Multi-label         Multi-class          Single-class        Binary
                      classification      classification       classification      classification
--------------------- ------------------- -------------------- ------------------- ---------------
Size $C               $\in \mathbb{N}^+$  $\in \mathbb{N}^+$   $\in \mathbb{N}^+$  $= 1$
= |\vec{\hat{x}}|
= |\vec{y}|$

Number of             $\leq C$            $\leq C$             $= 1$               $= 1$
relevant
classes

Output activation     Sigmoid             Softmax              Softmax             Sigmoid
$\sigma(\vec{x})$

Output                Probabilities       Probability          Probability         Probability
$\vec{\hat{x}}                            distribution         distribution
= \sigma(\vec{x})$

Target                Probabilities       Probability          One-hot             Binary scalar
$\vec{y}$                                 distribution         binary vector

Loss function         Sum of binary       Cross-entropy        Categorical         Binary
$\lambda(             cross-entropies     (@sec:ce)            cross-entropy       cross-entropy
\vec{\hat{x}},        (@sec:bce_sum)                           (@sec:cce)          (@sec:bce)
\vec{y})$
--------------------------------------------------------------------------------------------------

: Comparison of classification types


## Losses

### Regression Losses

#### Mean Absolute Error (L1 Loss) {#sec:mae}

$$
\lambda(\vec{\hat{x}}, \vec{y})
= \frac{\sum_{i=1}^C(y_i - \hat{x}_i)}{n}
$$

- $\vec{\hat{x}} = \sigma(\vec{x}) \in \mathbb{R}^{C} : \sum_{i=1}^C(\hat{x}_i) = 1$: output vector
- $\vec{y} \in \mathbb{R}^{C} : \sum_{i=1}^C(y_i) = 1$: target vector
- $C$: number of classes


#### Mean Squared Error (L2 Loss) {#sec:mse}

$$
\lambda(\vec{\hat{x}}, \vec{y})
= \frac{\sum_{i=1}^C(y_i - x_i)^2}{n}
$$

- $\vec{\hat{x}} = \sigma(\vec{x}) \in \mathbb{R}^{C} : \sum_{i=1}^C(\hat{x}_i) = 1$: output vector
- $\vec{y} \in \mathbb{R}^{C} : \sum_{i=1}^C(y_i) = 1$: target vector
- $C$: number of classes

Note: Sensitive to outliers.


#### Huber Loss {#sec:huber_loss}

L2 loss for small values, L1 loss for large values.


### Cross-Entropy Losses

#### Cross-Entropy {#sec:ce}

$$
\lambda(\vec{\hat{x}}, \vec{y})
= -\sum_{i=1}^C\big(y_i * \log(\hat{x}_i)\big)
$$

- $\vec{\hat{x}} = \sigma(\vec{x}) \in [0,1]^{C} : \sum_{i=1}^C(\hat{x}_i) = 1$: output vector (probability distribution)
- $\vec{y} \in [0,1]^{C} : \sum_{i=1}^C(y_i) = 1$: target vector (probability distribution)
- $C$: number of classes

Note: The logarithm punishes bigger errors higher than small errors.
The efficacy of this strategy is backed by empirical evidence [?].

Assumptions:

- Multinominal distribution [?]


#### Categorical Cross-Entropy {#sec:cce}

Just like cross-entropy, but reduced to the only operation that takes place when the target is a one-hot vector.

$$
\lambda(\vec{\hat{x}}, \vec{y})
= -\log(\hat{x}_i)
: i = \text{index of one-hot target class}
$$

- $\vec{\hat{x}} = \sigma(\vec{x}) \in [0,1]^{C}   : \sum_{i=1}^C(\hat{x}_i) = 1$: output vector (probability distribution)
- $\vec{y} \in \{0,1\}^{C} : \sum_{i=1}^C(y_i) = 1$: target vector (binary one-hot)


#### Binary Cross-Entropy (Logistic Regression) {#sec:bce}

$$
\lambda(\hat{x}, y)
= -\big(
  y * \log(\hat{x})
    + (1-y) * \log(1-\hat{x})
\big)
= \text{bce}(\hat{x}, y)
$$

- $\hat{x} = \sigma(x) \in [0,1]$: output (probability)
- $y \in \{0,1\}$: target (binary scalar)

Assumptions:

- Binominal distribution [?]


#### Sum of Binary Cross-Entropies {#sec:bce_sum}

$$
\lambda(\vec{\hat{x}}, \vec{y})
= \frac{\sum_{i=1}^C \text{bce}(\hat{x}_i, y_i)}{C}
$$

- $\vec{\hat{x}} = \sigma(\vec{x}) \in [0,1]^{C} : \sum_{i=1}^C(\hat{x}_i) = 1$: output vector (probabilities)
- $\vec{y} \in [0,1]^{C} : \sum_{i=1}^C(y_i) = 1$: target vector (probabilities)
- $C$: number of classes
