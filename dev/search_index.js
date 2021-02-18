var documenterSearchIndex = {"docs":
[{"location":"simulating/","page":"Simulating","title":"Simulating","text":"You can simulate a Hawkes process easily using the simulate function. Both constant and functional background rates are currently supported. ","category":"page"},{"location":"simulating/","page":"Simulating","title":"Simulating","text":"To simulate from a Hawkes process we first generate the background events from a Poisson process with the background rate. Then for each event generated from the background we simulate a inhomogeneous Poisson process with rate kappa*g(t-t_parent), any further events that arise are then also used to simulate further events. ","category":"page"},{"location":"simulating/#Constant-Background","page":"Simulating","title":"Constant Background","text":"","category":"section"},{"location":"simulating/","page":"Simulating","title":"Simulating","text":"kernF(x) = Distributions.Exponential(1/x)\n\nsimEvents = HawkesProcesses.simulate(0.5, 0.5, kernF, 100)","category":"page"},{"location":"simulating/#Functional-Background","page":"Simulating","title":"Functional Background","text":"","category":"section"},{"location":"simulating/","page":"Simulating","title":"Simulating","text":"If you have a non constant background rate it is as simple as writing that function out in Julia and passing it through to the simulation function. ","category":"page"},{"location":"simulating/","page":"Simulating","title":"Simulating","text":"bgF(x) = 0.5 * (x/100)\n\nsimEvents = HawkesProcesses.simulate(bgF, 0.5, kernF, 100)","category":"page"},{"location":"simulating/#Functional-Kappa","page":"Simulating","title":"Functional Kappa","text":"","category":"section"},{"location":"simulating/","page":"Simulating","title":"Simulating","text":"TBC ","category":"page"},{"location":"simulating/#Marked-Hawkes-Process","page":"Simulating","title":"Marked Hawkes Process","text":"","category":"section"},{"location":"simulating/","page":"Simulating","title":"Simulating","text":"TBC","category":"page"},{"location":"simulating/#Predicting-by-Simulating-Forward","page":"Simulating","title":"Predicting by Simulating Forward","text":"","category":"section"},{"location":"simulating/","page":"Simulating","title":"Simulating","text":"Simulating forward is the process of using the already occurred events to simulate future events. ","category":"page"},{"location":"simulating/","page":"Simulating","title":"Simulating","text":"newEvents = simulate_forward(events, maxT, startT, bgVal, kappaVal, kern)","category":"page"},{"location":"#HawkesProcesses.jl","page":"Home","title":"HawkesProcesses.jl","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"CurrentModule=HawkesProcesses","category":"page"},{"location":"","page":"Home","title":"Home","text":"Pages = [\"simulating.md\"]\nDepth = 1","category":"page"},{"location":"#Functions","page":"Home","title":"Functions","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"fit(events::Array{<:Number, 1}, maxT::Number, its::Int64)\nhierarchical_fit(eventTimesList, maxT::Number, its::Int64)\nintensity(ts::Array{<:Number, 1}, events::Array{<:Number, 1}, background, kappa::Float64, kernel::Function)\ncompensator(ts::Number, events::Array{<:Number}, bg::Number, kappa::Number, kern::Distributions.Distribution)\nsimulate(bg, kappa::Float64, kern::Function, maxT::Number)\nlikelihood(events::Array{<:Number, 1}, background::Float64, kappa::Float64, kernel::Distributions.Distribution, maxT::Number)\ntime_change_null(events::Array{<:Number}, maxT::Number)\ntime_change_hawkes(events::Array{<:Number}, bg::Number, kappa::Number, kern::Distributions.Distribution)","category":"page"},{"location":"#HawkesProcesses.fit-Tuple{Array{var\"#s1\",1} where var\"#s1\"<:Number,Number,Int64}","page":"Home","title":"HawkesProcesses.fit","text":"fit(events::Array{<:Number, 1}, maxT::Number, its::Int64)\n\nArguments\n\nevents The array of event times to fit the Hawkes process too.\nmaxT The boundary time over which the events were observed.\nits Number of iterations to sample for.\n\nNotes\n\nAll events must be unique\n\n\n\n\n\n","category":"method"},{"location":"#HawkesProcesses.hierarchical_fit-Tuple{Any,Number,Int64}","page":"Home","title":"HawkesProcesses.hierarchical_fit","text":"hierarchical_fit(eventsTimesList, maxT, its)\n\nArguments\n\neventTimesList An array of arrays of events. \nmaxT The boundary time over which the events were observed. \nits Number for of iterations to sample for.\n\n\n\n\n\n","category":"method"},{"location":"#HawkesProcesses.intensity-Tuple{Array{var\"#s1\",1} where var\"#s1\"<:Number,Array{var\"#s2\",1} where var\"#s2\"<:Number,Any,Float64,Function}","page":"Home","title":"HawkesProcesses.intensity","text":"intensity(ts, events, background, kappa, kernel)\n\nEvaluate the intensity over a timegrid for some observed events with given Hawkes parameters.\n\nArguments\n\nts::Array{<:Number,1}: time grid to evalue the intensity over\nevents::Array{<:Number,1}: Events of the process\nbackground: Background rate\nkappa::Float64: Kappa value\nkernel::Function: Kernel function\n\nNotes\n\nkappa must be between 0 and 1\n\n\n\n\n\n","category":"method"},{"location":"#HawkesProcesses.compensator-Tuple{Number,Array{var\"#s2\",N} where N where var\"#s2\"<:Number,Number,Number,Distributions.Distribution}","page":"Home","title":"HawkesProcesses.compensator","text":"compensator(ts::Number, events::Array{<:Number}, bg::Number, kappa::Number, kern::Distributions.Distribution)\n\nThe compensator or integrated intensity function. \n\nArguments\n\nts::Number time to which evaluate the integrated intensity function. \nevents::Array{<:Number} events from the intensity function. \nbg::Number Background rate. \nkappa::Number Kappa parameter\nkern::Distributions.Distribution Distribution of the kernel. \n\nExamples\n\n\n\n\n\n","category":"method"},{"location":"#HawkesProcesses.simulate-Tuple{Any,Float64,Function,Number}","page":"Home","title":"HawkesProcesses.simulate","text":"simulate(bg::Number, kappa::Float64, kern::Function, maxT::Number)\n\nSimulate a Hawkes process between 0 and maxT with parameters bg, kappa, kern.\n\nArguments\n\nbg: The background rate of the Hawkes process. Constant or positive function. \nkappa: The kappa parameter of the Hawkes process.\nkern : The kernel function of the Hawkes process.\nmaxT : Maximum time that the Hawkes process will be simulated for.\n\nNotes\n\nkappa must be between 0 and 1 for a stable Hawkes process.\n\nExamples\n\n``julia kern_f(x) = pdf.(Distributions.Exponential(1/0.5), x)\n\nsimevents = simulate(0.5, 0.5, kern_f, 100) ``\n\n\n\n\n\n","category":"method"},{"location":"#HawkesProcesses.likelihood-Tuple{Array{var\"#s2\",1} where var\"#s2\"<:Number,Float64,Float64,Distributions.Distribution,Number}","page":"Home","title":"HawkesProcesses.likelihood","text":"likelihood(events::Array{<:Number, 1}, background::Float64, kappa::Float64, kernel::Distributions.Distribution, maxT::Number)\n\nCalculate the log likelihood of a Hawkes process for given parameters.\n\nArguments\n\nevents Vector of events to calculate the likelihood for. \nbackground Background rate. \nkappa Kappa parameter.\nkernel Function or distribution of the kernel.\nmaxT Maximum time of the process. \n\nNotes\n\nThe kernel function must be a proper probability distribution.\n\nExamples\n\n\n\n\n\n","category":"method"},{"location":"#HawkesProcesses.time_change_null-Tuple{Array{var\"#s2\",N} where N where var\"#s2\"<:Number,Number}","page":"Home","title":"HawkesProcesses.time_change_null","text":"time_change_null(events, maxT)\n\nCalculate the residuals for some events from a constant Poisson process. \n\nArguments\n\nevents::Array{<:Number} the events from the process. \nmaxT::Number the maximum window time.  \n\n\n\n\n\n","category":"method"},{"location":"#HawkesProcesses.time_change_hawkes-Tuple{Array{var\"#s2\",N} where N where var\"#s2\"<:Number,Number,Number,Distributions.Distribution}","page":"Home","title":"HawkesProcesses.time_change_hawkes","text":"time_change_hawkes(events, bg, kappa, kern)\n\nCalculate the residuals using the time change theorem for a Hawkes process. \n\nArguments\n\nevents::Array{<:Number} the events from the process. \nbg the background rate of the Hawkes process. \nkappa the kappa parameter of the Hawkes process.\nkern the kernel distriubtion of the Hawkes process. \n\n\n\n\n\n","category":"method"},{"location":"#Index","page":"Home","title":"Index","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"inference/","page":"Inference","title":"Inference","text":"This package was designed to provide an implementation of an efficient Bayesian sampling algorithm but using the available functions you can also use frequentist methods. ","category":"page"},{"location":"inference/#Bayesian-Inference","page":"Inference","title":"Bayesian Inference","text":"","category":"section"},{"location":"inference/","page":"Inference","title":"Inference","text":"For each sample of the posterior distribution the algorithm guesses what events are the background events and those that are from other events. Then using all the background events the background rate is sampled, the number of children events from each event, the kappa parameter is updated and the relative times between the child events and their parent events are used to update the kernel parameter. ","category":"page"},{"location":"inference/","page":"Inference","title":"Inference","text":"bg = 0.5\nkappa = 0.5\nkernF(x) = Distriubtions.Exponential(1/0.5)\nmaxT = 100\n\nsimEvents = HawkesProcesses.simulate(bg, kappa, kernF, maxT)\n\nbgSamples, kappaSamples, kernSamples = HawkesProcesses.fit(simEvents, maxT, 1000)","category":"page"},{"location":"inference/","page":"Inference","title":"Inference","text":"Here we now have MCMC chains for the three different parameters. ","category":"page"},{"location":"inference/","page":"Inference","title":"Inference","text":"At the minute, only the exponential distribution for the kernel is implemented.  In future releases this will be changed to be generic for any kernel you specify. ","category":"page"},{"location":"inference/#Frequentist-Inference","page":"Inference","title":"Frequentist Inference","text":"","category":"section"},{"location":"inference/","page":"Inference","title":"Inference","text":"Another (and potentially quicker) method of inferring the parameters is to maximise the likelihood function. ","category":"page"},{"location":"inference/","page":"Inference","title":"Inference","text":"using Optim\n\nopt = optimize(x-> -1*HawkesProcesses.likelihood(simEvents, \n                                                 x[1],\n                                                 x[2],\n                                                 Distriubtions.Exponential(x[3]),\n                                                 maxT),\n                rand(3))\nOptim.minimizer(opt)","category":"page"},{"location":"inference/","page":"Inference","title":"Inference","text":"Simply passing the likelihood function through to the optimiser allows for a quick and easy estimate of the parameters. ","category":"page"},{"location":"modelchecking/","page":"Model Checking","title":"Model Checking","text":"After fitting a Hawkes process model you want to critique that model to make sure it is suitable.  You want to check that the clustering the Hawkes has picked out is a true effect and also that the probabilities are calibrated correctly. ","category":"page"},{"location":"modelchecking/#Likelihood","page":"Model Checking","title":"Likelihood","text":"","category":"section"},{"location":"modelchecking/","page":"Model Checking","title":"Model Checking","text":"A simple way to estimate the goodness of fit is by calculating comparing the likelihood of some data across models.  ","category":"page"},{"location":"modelchecking/","page":"Model Checking","title":"Model Checking","text":"hawkesLikelihood = HawkesProcesses.likelihood(events, estimatedBackground, estimatedKappa estimatedKernel, maxT)","category":"page"},{"location":"modelchecking/","page":"Model Checking","title":"Model Checking","text":"Then by looking at what likelihood is larger can suggest which model is better suited to the data. ","category":"page"},{"location":"modelchecking/#Residuals","page":"Model Checking","title":"Residuals","text":"","category":"section"},{"location":"modelchecking/","page":"Model Checking","title":"Model Checking","text":"The time change theorem provides a residual method for checking the suitability of  point process model. By using the intensity function with estimated parameters the times of the events are rescaled. If the intensity function is correct, then the transformed event time differences will be distributed as unit exponential. All of this is contained in the time_change_hawkes function. The 'null' model is also calculated under the assumption of a constant Poisson process with time_change_null. ","category":"page"},{"location":"modelchecking/","page":"Model Checking","title":"Model Checking","text":"x, y = time_change_hawkes(eventTimes, bgVal, kappaVal, kern)\nplot(x, y)","category":"page"},{"location":"modelchecking/#Probability-Calibration","page":"Model Checking","title":"Probability Calibration","text":"","category":"section"},{"location":"modelchecking/","page":"Model Checking","title":"Model Checking","text":"TBC","category":"page"}]
}
