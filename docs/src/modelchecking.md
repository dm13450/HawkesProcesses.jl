
After fitting a Hawkes process model you want to critique that model to make sure it is suitable. 
You want to check that the clustering the Hawkes has picked out is a true effect and also that the probabilities are calibrated correctly. 

## Likelihood

A simple way to estimate the goodness of fit is by calculating comparing the likelihood of some data across models.  

```julia 
hawkesLikelihood = HawkesProcesses.likelihood(events, estimatedBackground, estimatedKappa estimatedKernel, maxT)
```
Then by looking at what likelihood is larger can suggest which model is better suited to the data. 


## Residuals 

The time change theorem provides a residual method for checking the suitability of  point process model. By using the intensity function with estimated parameters the times of the events are rescaled. If the intensity function is correct, then the transformed event time differences will be distributed as unit exponential. All of this is contained in the `time_change_hawkes` function. The 'null' model is also calculated under the assumption of a constant Poisson process with `time_change_null`. 

```@example
x, y = time_change_hawkes(eventTimes, bgVal, kappaVal, kern)
plot(x, y)
```



## Probability Calibration

TBC