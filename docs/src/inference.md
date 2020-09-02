
This package was designed to provide an implementation of an efficient Bayesian sampling algorithm but using the availabel functions you can also use frequentist methods. 

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


### Frequentist Inference

Test