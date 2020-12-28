"""
    hierarchical_fit(eventsTimesList, maxT, its)

# Arguments 

* `eventTimesList` An array of arrays of events. 
* `maxT` The boundary time over which the events were observed. 
* `its` Number for of iterations to sample for.


"""
function hierarchical_fit(eventTimesList, maxT, its)
    nSamples = length(eventTimesList)
    nEvents = map(length, eventTimesList)
    eventDifferences = map(event_difference_list, eventTimesList)
    maxTDifferences = map(x-> maxT .- x, eventTimesList)

    bgSamples = zeros(Float64, its)
    kappaSamples = zeros(Float64, its)
    kernSamples = zeros(Float64, its)

    bgSamples[1] = rand()
    kappaSamples[1] = rand()
    kernSamples[1] = rand()

    kernSample = kernSamples[1]
    kernDistribution::Exponential{Float64} = Distributions.Exponential(1/kernSample)
    kernFunc(x::Number) = Distributions.pdf(kernDistribution, x)

    sampleData = map(j-> sample_parents(eventTimesList[j], bgSamples[1], kappaSamples[1], kernFunc, eventDifferences[j]), 1:nSamples)

    for i in 2:its
        totalBG = mapreduce(x->x[2], +, sampleData)
        bgSamples[i] = Distributions.rand(Distributions.Gamma(0.01 + totalBG, 1/(0.01+nSamples))) / maxT

        H_tildes = map(x->sum(cdf.(kernDistribution, x)), maxTDifferences)
        totalChildEvents = mapreduce(x -> sum(x[3]), +, sampleData)
        kappaSamples[i] = Distributions.rand(Distributions.Gamma(0.01 + totalChildEvents, 1/(0.01 + sum(H_tildes))))

        totalShiftTimes = mapreduce(x -> sum(x[4]), +, sampleData)
        nShiftTimes = mapreduce(x -> length(x[4]), +, sampleData)
        kernSample = Distributions.rand(Distributions.Gamma(0.01 + nShiftTimes, 1/(0.01 + totalShiftTimes)))
        kernSamples[i] = kernSample
        kernDistribution = Distributions.Exponential(1/kernSamples[i])

        sampleData = map(j-> sample_parents(eventTimesList[j], bgSamples[i], kappaSamples[i], kernFunc, eventDifferences[j]), 1:nSamples)

    end


    (bgSamples, kappaSamples, kernSamples)
end
