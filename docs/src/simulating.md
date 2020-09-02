
You can simulate a Hawkes process easily using the `simulate` function. Both constant and functional background rates are currently supported. 

To simulate from a Hawkes process we first generate the background events from a Poisson process with the background rate. Then for each event generated from the background we simulate a inhomogenous Poisson process with rate kappa*g(t-t_parent), any further events that arise are then also used to simulate further events. 

### Constant Background 

```@example
kernF(x) = Distributions.Exponential(1/x)

simEvents = HawkesProcesses.simulate(0.5, 0.5, kernF, 100)
```

### Functional Background

If you have a non constant background rate it is as simple as writing that function out in Julia and passing it through to the simulation function. 

```@example
bgF(x) = 0.5 * (x/100)

simEvents = HawkesProcesses.simulate(bgF, 0.5, kernF, 100)
```

### Functional Kappa

TBC 

### Marked Hawkes Process

TBC
