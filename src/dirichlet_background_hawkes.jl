using RCall

function HawkesFitDirichletBackground(eventTimes, maxT, its)

    R"require(dirichletprocess)"

    @rput maxT
    
    nEvents = size(eventTimes, 1)
    eventDifferences = eventDifferenceMatrix(eventTimes)

    bgSamples = zeros(its)
    kappaSamples = zeros(its)
    kernSamples = zeros(its)
    bgFuncSamples = Array{Function}(its)
    
    bgSamples[1] = rand()
    kappaSamples[1] = rand()
    kernSamples[1] = rand()
    kernFuncInitial(x) = Distributions.pdf.(Distributions.Exponential(1/kernSamples[1]), x)
    
    parentVectorSample = parentSample(eventDifferences, bgSamples[1], kappaSamples[1], kernFuncInitial)

    bgEventTimes = eventTimes[parentVectorSample .== 0]
    
    @rput bgEventTimes
    
    cp = rcopy(R"""
               dp <- dirichletprocess::DirichletProcessBeta(bgEventTimes, maxT)
               dp <- dirichletprocess::Fit(dp, 100, TRUE, FALSE)
               pc <- dirichletprocess::PosteriorClusters(dp)
              
               cbind(pc$weights,
               (pc$params[[1]]*pc$params[[2]])/maxT,
               (1-(pc$params[[1]]/maxT))*pc$params[[2]])
    """)

    mm = Distributions.MixtureModel(Distributions.Beta, map(tuple, cp[:,2], cp[:,3]), cp[:,1]/sum(cp[:,1]))

    bgFuncInitial(x) = (bgSamples[1]/maxT) * Distributions.pdf.(mm, x/maxT)
    bgFuncSamples[1] = bgFuncInitial
    
    for i=2:its
        numBG, chEvents, shiftTimes = countEvent(parentVectorSample, eventTimes)

        bgEventTimesNew = eventTimes[parentVectorSample .== 0]
        @rput bgEventTimesNew

        cp = rcopy(R"""
               dp <- dirichletprocess::ChangeObservations(dp, bgEventTimesNew)
               dp <- dirichletprocess::Fit(dp, 10, TRUE, FALSE)
               pc <- dirichletprocess::PosteriorClusters(dp)
               cbind(pc$weights,
               (pc$params[[1]]*pc$params[[2]])/maxT,
               (1-(pc$params[[1]]/maxT))*pc$params[[2]])
             """)

        mm = Distributions.MixtureModel(Distributions.Beta, map(tuple, cp[:,2], cp[:,3]), cp[:,1])
        bgSamples[i] = Distributions.rand(Distributions.Gamma(0.01 + numBG, 1/(0.01+1)))
        kappaSamples[i] = Distributions.rand(Distributions.Gamma(0.01 + sum(chEvents), 1/(0.01+nEvents)))
        kernSample = Distributions.rand(Distributions.Gamma(0.01 + size(shiftTimes, 1), 1/(0.01 + sum(shiftTimes))))
        kernSamples[i] = kernSample
        
        kernFunc(x) = Distributions.pdf.(Distributions.Exponential(1/kernSamples[i]), x)
        bgFunc(x) = (bgSamples[i]/maxT) * Distributions.pdf.(mm, x/maxT)

        bgFuncSamples[i] = bgFunc
        
        parentVectorSample = parentSample(eventDifferences,  bgFunc, kappaSamples[i], kernFunc)
    end

    bgSamples, kappaSamples, kernSamples, bgFuncSamples

end

