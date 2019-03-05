using LinearAlgebra


function eventDifferenceMatrix(eventTimes)
    eventDiff = eventTimes .- eventTimes'
    eventDiff[diagind(eventDiff)] .= -1
    transpose(hcat(eventTimes, eventDiff))
end
