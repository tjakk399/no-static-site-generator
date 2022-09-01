---
title: Improving the Model
subtitle: Deep Learning Notes
tags:
  - Machine Learning
  - Deep Learning
---

## (Multi)-Collinearity (only an issue in linear regression?)

High linear correlation between two or more independent variables.

- -> Regression coefficients are not uniquely determined
- -> Regression coefficients are not unique
- -> Impedes the ability to predict the regression coefficients of both variables
- -> Overfitting?

## Bias-Variance Tradeoff

There is a trade-off between a model's ability to minimize bias and variance.

### Bias error

Def: Difference between average prediction and correct value

- <- Wrong assumptions in the learning algorithm
- -> Does not learn training well.
- -> High errors on training and test
- -> Underfitting

### Variance

Def: Variability of predictions for a given data point

- <- High sensitivity to small fluctuations in training data
- -> Modeling of random noise in training data
- -> High errors on test
- -> Overfitting

## Solutions to Underfitting

- Improve data.
- Increase model complexity.

## Solutions to Overfitting

- <- Model is too complex.
- -> Constrain the model to a smaller set of possible solutions.

### Reduction of Model Size

Fewer layers and/or parameters.

### Noise-Injection

Apply randomness in training to enforce reduction in variance.

#### Dropout

Def: Randomly ignoring outputs per layer

- -> Noise-injection into hidden units
- -> Forcing alternating paths for signals
- -> Equivalent to training networks with different architectures in parallel
- -> Encourages sparse representations.
- -> Reduction of model variance
- -> Better generalization

#### Batch Normalization

Def: Project hidden units (features) into a fixed range.

Ex: Gaussian-like space with fixed mean and variance in range $[-1,+1]$.

$$
\hat{x}_i = \frac{x_i - \mu_{minibatch}}{\sqrt{\sigma_{minibatch}^2} + \epsilon}
$$

$$
BN_{\gamma,\beta}(x_i) = \gamma \hat{x}_i + \beta
$$

- $\mu_{minibatch}$: mean of values over minibatch
- $\sigma_{minibatch}^2$: variance of values over minibatch

For each hidden unit:

1. Subtract mean of minibatch.
2. Scale by variance of minibatch.
3. Multiply with deviation of all hidden units within the minibatch.

#### Label Smoothing (Classification)

Def: Add noise to targets of classification.

- <- Softmax of output layer can never achieve perfect binary vector.
- -> Output never perfectly matches target.
- -> Training will always continue.
- --> Overfitting
- -> Perfect convergence is impossible.

The ones and zeros in binary target vectors are replaced with smoothed values:

$$
0 \rightarrow \frac{\epsilon}{k-1}
$$

$$
1 \rightarrow 1-\epsilon
$$

- $k$: number of classes

### Regularization ("weight decay")

Assumption: smaller weights produce simpler models and avoid overfitting.

Def: Depressing network weights by adding a weight-dependent penalty to the final loss.

- -> Simpler model
- -> Trade higher bias for reduced variance.

Biases are usually not regularized.

#### L1-Norm Regularization (weight sparsity)

$$
loss = error(x, y) + \lambda \sum_{i=1}^n w_i
$$

- -> The gradient of each weight $w_i$ is added (penalized) with $\lambda \pm w_i$.
- -> Non-linear scaling of each weight $w_i$ by constant factor with alternating sign
- -> More weights are scaled to zero.
- -> Increases sparsity in weights.
- -> Some features are discarded entirely.
- -> Reduction of model variance
- -> Better generalization

#### L2-Norm Regularization (weight depression via Euclidean Norm)

$$
loss = error(x, y) + \lambda \sqrt{\sum_{i=1}^n w_i^2}
$$

- -> The gradient of each weight $w_i$ is added (penalized) with $\lambda w_i$.
- -> Linear scaling of each weight $w_i$ (i.e. by constant factor)
- -> Big impact on weights that contribute little to the loss
- -> Small impact on weights that contribute little to the loss
- -> Reduction of model variance
- -> Better generalization

