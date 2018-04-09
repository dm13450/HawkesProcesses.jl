function HawkesFit(eventTimes, maxT, its)
    nEvents = size(eventTimes, 1)
    eventDifferences = eventDifferenceMatrix(eventTimes)

    bgSamples = zeros(its)
    kappaSamples = zeros(its)
    kernSamples = zeros(its)

    bgSamples[1] = rand()
    kappaSamples[1] = rand()
    kernSamples[1] = rand()
    kernFuncInitial(x) = Distributions.pdf.(Distributions.Exponential(1/kernSamples[1]), x)
    
    parentVectorSample = parentSample(eventDifferences,  bgSamples[1], kappaSamples[1], kernFuncInitial)
    kernSample = 0.0

    for i=2:its
        numBG, chEvents, shiftTimes = countEvent(parentVectorSample, eventTimes)

        bgSamples[i] = Distributions.rand(Distributions.Gamma(0.01 + numBG, 1/(0.01+maxT)))
        kappaSamples[i] = Distributions.rand(Distributions.Gamma(0.01 + sum(chEvents), 1/(0.01+nEvents)))
        kernSample = Distributions.rand(Distributions.Gamma(0.01 + size(shiftTimes, 1), 1/(0.01 + sum(shiftTimes))))
        kernSamples[i] = kernSample
        
        kernFunc(x) = Distributions.pdf.(Distributions.Exponential(1/kernSamples[i]), x)
        parentVectorSample = parentSample(eventDifferences,  bgSamples[i], kappaSamples[i], kernFunc)
    end

    bgSamples, kappaSamples, kernSamples
end
