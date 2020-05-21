# HawkesProcesses

A Julia package for fitting, analysing and plotting Hawkes processes.

The parameters of the Hawkes process can be inferred using the enhanced Bayesian MCMC algorithm as discussed here. 

## Features

I provide a number of different tools to both fit and analyse a collection of events using Hawkes processes.

### Simulation of a Hawkes process

```julia
bg = 0.5
kappa = 0.5
kernel(x) = pdf.(Distributions.Exponential(1/0.5), x)
maxT = 100
simevents = HawkesProcesses.simulate(bg, kappa, kernel, maxT)
```

### Enhance Bayesian Inference

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
