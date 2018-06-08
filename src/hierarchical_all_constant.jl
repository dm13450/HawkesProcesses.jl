function HierarchicalHawkesFit(eventTimesList, maxT, its)

    nObs = size(eventTimesList)[1]
    nEvents = mapreduce(x->size(x,1), +, eventTimesList)

    eventDifferences = map(eventDifferenceMatrix, eventTimesList)

    bgSamples = zeros(its)
    kappaSamples = zeros(its)
    kernSamples = zeros(its)

    bgSamples[1] = rand()
    kappaSamples[1] = rand()
    kernSamples[1] = rand()

    kernDistribution::Distributions.Exponential{Float64} =
                                    Distributions.Exponential(1/kernSamples[1])
    kernFunc(x) = Distributions.pdf.(kernDistribution, x)

    parentVectorSampleArray = map( x -> parentSample(x,
                                                     bgSamples[1],
                                                     kappaSamples[1],
                                                     kernFunc), eventDifferences)

    for i=2:its

        eventCounts = map((x,y) -> countEvent(x, y), parentVectorSampleArray, eventTimesList)

        numBG = mapreduce(x-> x[1], +, eventCounts)
        chEvents = mapreduce(x -> x[2], vcat, eventCounts)
        shiftTimes = mapreduce(x -> x[3], vcat, eventCounts)

        bgSamples[i] = Distributions.rand(Distributions.Gamma(0.01 + numBG, 1/(0.01+(nObs))))/maxT

        kappaSamples[i] = Distributions.rand(Distributions.Gamma(0.01 + sum(chEvents), 1/(0.01+nEvents)))

        kernSample = Distributions.rand(Distributions.Gamma(0.01 + size(shiftTimes, 1), 1/(0.01 + sum(shiftTimes))))
        kernSamples[i] = kernSample
        kernDistribution::Distributions.Exponential{Float64} = Distributions.Exponential(1/kernSample)

        parentVectorSampleArray = map( x -> parentSample(x,
                                                         bgSamples[i],
                                                         kappaSamples[i],
                                                         kernFunc),  eventDifferences)
    end

    bgSamples, kappaSamples, kernSamples

end
