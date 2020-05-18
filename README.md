# HawkesProcesses

A Julia package for fitting Hawkes processes.


## Features

 * Hawkes simulation
 * Likelihood evaluation
 * Intensity calculation
 * Enhanced Bayesian inference

This package provides a Bayesian method to estimate the parameters of a Hawkes process.
This package can also be used to perform MLE by optimising the likelihood function.

Currently Bayesian sampling can be performed with constant background, constant kappa and exponential kernel.
In future releases this will be transformed into a generic parameter sets.   


## To Do

* Make functions consistent with Julia style guide.
* Check type safety
* Check boundary condition effect.
* Return parent vector from simulate.


## Next Features

* Likelihood with functional background
* Generic Bayesian inference.
