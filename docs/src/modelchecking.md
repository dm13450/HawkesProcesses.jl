
After fitting a Hawkes process model you want to critique that model to make sure it is suitable. 
You want to check that the clustering the Hawkes has picked out is a true effect and also that the probabilites are calibrated correctly. 

## Likelihood

A simple way to estimate the goodness of fit is by calculating comparing the likelihood of some data across models.  

```julia 
hawkesLikelihood = HawkesProcesses.likelihood(events, estimatedBackground, estimatedKappa estimatedKernel, maxT)
```
Then by looking at what likelihood is larger can suggest which model is better suited to the data. 


## Residuals 

TBC

## Probability Calibration

TBC