
This package was designed to provide an implementation of an efficient Bayesian sampling algorithm but using the available functions you can also use frequentist methods. 

### Bayesian Inference

For each sample of the posterior distribution the algorithm guesses what events are the background events and those that are from other events. Then using all the background events the background rate is sampled, the number of children events from each event, the kappa parameter is updated and the relative times between the child events and their parent events are used to update the kernel parameter. 

```@example 
bg = 0.5
kappa = 0.5
kernF(x) = Distriubtions.Exponential(1/0.5)
maxT = 100

simEvents = HawkesProcesses.simulate(bg, kappa, kernF, maxT)

bgSamples, kappaSamples, kernSamples = HawkesProcesses.fit(simEvents, maxT, 1000)
```

Here we now have MCMC chains for the three different parameters. 

At the minute, only the exponential distribution for the kernel is implemented. 
In future releases this will be changed to be generic for any kernel you specify. 


### Frequentist Inference

Another (and potentially quicker) method of inferring the parameters is to maximise the likelihood function. 

```@example
using Optim

opt = optimize(x-> -1*HawkesProcesses.likelihood(simEvents, 
                                                 x[1],
                                                 x[2],
                                                 Distriubtions.Exponential(x[3]),
                                                 maxT),
                rand(3))
Optim.minimizer(opt)
```

Simply passing the likelihood function through to the optimiser allows for a quick and easy estimate of the parameters. 