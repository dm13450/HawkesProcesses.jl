"""

Sample the parent label of each event for given parameters.

"""
function sample_parents(events::Array{<:Number, 1}, bg, kappa::Number, kern::Function)
    eventdifferencelist = event_difference_list(events)
    sample_parents(events, bg, kappa, kern, eventdifferencelist)
end

function sample_parents(events::Array{<:Number, 1}, bg, kappa::Number, kern::Function, eventdifferencelist)
    n = length(eventdifferencelist)
    numBackgroundEvents = 0
    childEventsVector = zeros(Int64, n)
    childShiftTime = zeros(Float64, n)
    parents = Array{Int64, 1}(undef, n)

    for (i, eventdiff) in enumerate(eventdifferencelist)
        parent = sample_parent(events[i], bg, kappa, kern, eventdiff)
        parents[i] = parent

        if parent == 0
            numBackgroundEvents += 1
            continue
         end
        childEventsVector[parent] += 1
        childShiftTime[i] = events[i] - events[parent]

    end
    (parents, numBackgroundEvents, childEventsVector,  childShiftTime[childShiftTime .!= 0])
end

function sample_parent(event::Number, bg, kappa::Number, kern::Function, eventdifferences::Array{<:Number, 1})
    probs = event_parent_prob(event, bg, kappa, kern, eventdifferences)
    StatsBase.sample(StatsBase.Weights(probs)) - 1
end
