function _fit(events::Array{<:Number, 1}, maxT::Number, its::Int64, bgUpdateFunction::Function, kappaUpdateFunction::Function, kernUpdateFunction::Function)

    nEvents = length(events)
    eventDifferences = event_difference_list(events)
    maxTDifferences = maxT .- events

    bgSamples = zeros(Float64, its)
    kappaSamples = zeros(Float64, its)
    kernSamples = zeros(Float64, its)

    bgSamples[1] = rand()
    kappaSamples[1] = rand()
    kernSamples[1] = rand()

    kernSample = kernSamples[1]
    kernDistribution::Exponential{Float64} = Distributions.Exponential(1/kernSample)
    kernFunc(x::Number) = Distributions.pdf(kernDistribution, x)

    parentVectorSample, numBG, chEvents, shiftTimes = sample_parents(events, bgSamples[1], kappaSamples[1], kernFunc, eventDifferences)

    for i = 2:its

        bgEvents = events[parentVectorSample .== 0]
        bgSamples[i] = bgUpdateFunction(bgEvents, maxT)

        H_tilde::Float64 = sum(cdf.(kernDistribution, maxTDifferences))
        kappaSamples[i] = kappaUpdateFunction(chEvents, H_tilde)

        kernSample = kernUpdateFunction(shiftTimes)
        kernSamples[i] = kernSample
        kernDistribution = Distributions.Exponential(1/kernSamples[i])

        parentVectorSample, numBG, chEvents, shiftTimes = sample_parents(events, bgSamples[i], kappaSamples[i], kernFunc, eventDifferences)
    end
    bgSamples, kappaSamples, kernSamples
end