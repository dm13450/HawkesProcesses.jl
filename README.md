[![Build Status](https://travis-ci.org/dm13450/HawkesProcesses.jl.svg?branch=master)](https://travis-ci.org/dm13450/HawkesProcesses.jl)

[![Coverage Status](https://coveralls.io/repos/github/dm13450/HawkesProcesses.jl/badge.svg?branch=master)](https://coveralls.io/github/dm13450/HawkesProcesses.jl?branch=master)

# HawkesProcesses

A Julia package for fitting, analysing and plotting Hawkes processes.

You can find the maths behind the algorithm [here](https://dm13450.github.io/assets/hawkesprocesses.pdf). The Bayesian sampling algorithm is a generic version of the `bayesianETAS` package from CRAN which can be found [here](https://cran.r-project.org/web/packages/bayesianETAS/index.html).

## Features

I provide a number of different tools to both fit and analyse a collection of events using Hawkes processes.

### Simulate a Hawkes process

```julia
bg = 0.5
kappa = 0.5
kernel(x) = pdf.(Distributions.Exponential(1/0.5), x)
maxT = 100
simevents = HawkesProcesses.simulate(bg, kappa, kernel, maxT)
```

### Enhanced Bayesian Inference

Sample the parameters of a Hawkes process using the latent variable Bayesian MCMC algorithm.
Currently only constant background, constant κ and exponential kernel are available, but this will be extend to generic functions in the future.  

```julia
bgSamps, kappaSamps, kernSamps = HawkesProcesses.fit(simEvents, maxT, 1000)
```

### Calculate the likelihood for a Hawkes process

```julia
likelihood = HawkesProcesses.likelihood(simevents, bg, kappa, Distributions.Exponential(1/0.5))
```

 ### Intensity calculation

```julia
intensity = HawkesProcesses.intensity(ts, simevents, bg, kappa, kernel)
```

## To Do

* Make functions consistent with Julia style guide.
* Check type safety
* Return parent vector from simulate.

## Next Features

* Likelihood with functional background
* Generic Bayesian inference.
