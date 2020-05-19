"""
    fit(eventTimes, maxT, its)

# Arugments

* eventTimes The array of event times to fit the Hawkes process too.
* maxT The boundary time over which the events were observed.
* Number of iterations to sample for

# Notes

* All eventTimes must be unique

"""

function fit(eventTimes, maxT::Number, its::Int64)

    nEvents = length(eventTimes)
    eventDifferences = event_difference_list(eventTimes)
    maxTDifferences = maxT .- eventTimes

    bgSamples = zeros(Float64, its)
    kappaSamples = zeros(Float64, its)
    kernSamples = zeros(Float64, its)

    bgSamples[1] = rand()
    kappaSamples[1] = rand()
    kernSamples[1] = rand()

    kernSample = kernSamples[1]
    kernDistribution = Distributions.Exponential(1/kernSample)
    kernFunc(x) = Distributions.pdf.(kernDistribution, x)

    parentVectorSample, numBG, chEvents, shiftTimes = sample_parents(eventTimes, bgSamples[1], kappaSamples[1], kernFunc, eventDifferences)

    for i = 2:its

        bgSamples[i] = Distributions.rand(Distributions.Gamma(0.01 + numBG, 1/(0.01+1))) / maxT

        #if boundary_correction
        #    H_tilde = sum(cdf.(kernDistribution, maxTDifferences))
        #end

        kappaSamples[i] = Distributions.rand(Distributions.Gamma(0.01 + sum(chEvents), 1/(0.01 + nEvents)))
        kernSample = Distributions.rand(Distributions.Gamma(0.01 + length(shiftTimes), 1/(0.01 + sum(shiftTimes))))
        kernSamples[i] = kernSample

        kernDistribution = Distributions.Exponential(1/kernSamples[i])
        #kernFunc(x) = Distributions.pdf.(kernDistribution, x)
        parentVectorSample, numBG, chEvents, shiftTimes = sample_parents(eventTimes, bgSamples[i], kappaSamples[i], kernFunc, eventDifferences)
    end

    bgSamples, kappaSamples, kernSamples
end
