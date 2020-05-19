"""

Sample the parent label of each event for given parameters.

"""
function sample_parents(eventTimes, bg, kappa, kern::Function)
    eventdifferencelist = event_difference_list(eventTimes)
    sample_parents(eventTimes, bg, kappa, kern, eventdifferencelist)
end

function sample_parents(eventTimes, bg, kappa, kern, eventdifferencelist)
    n = length(eventdifferencelist)
    numBackgroundEvents = 0
    childEventsVector = zeros(Int64, n)
    childShiftTime = zeros(Float64, n)
    parents = Array{Int64, 1}(undef, n)

    for (i, eventdiff) in enumerate(eventdifferencelist)
        probs = event_parent_prob(eventTimes[i], bg, kappa, kern, eventdiff)

        parent = StatsBase.sample(StatsBase.Weights(probs)) - 1
        parents[i] = parent

        if parent == 0
            numBackgroundEvents += 1
            continue
         end
        childEventsVector[parent] += 1
        childShiftTime[i] = eventTimes[i] - eventTimes[parent]

    end
    (parents, numBackgroundEvents, childEventsVector,  childShiftTime[childShiftTime .!= 0])
end
