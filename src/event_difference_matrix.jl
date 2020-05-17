using LinearAlgebra


function eventDifferenceMatrix(eventTimes)
    eventDiff = eventTimes .- eventTimes'
    eventDiff[diagind(eventDiff)] .= -1
    transpose(hcat(eventTimes, eventDiff))
end

#To be tested and implemented into bayesian sampling

function event_diff(event, eventTimes)
    subEvents = eventsTimes[eventsTimes .<= event]
    event .- subEvents
end

function event_difference_list(eventTimes)
    map(x -> event_diff(event, eventTimes), eventTimes)
end
