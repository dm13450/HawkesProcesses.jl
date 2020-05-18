"""

Create an array of the difference between the event times.

# Notes

* The event times must be unique.

"""
function event_difference_list(eventTimes::Array{<:Number, 1})
    map(x -> event_diff(x, eventTimes), eventTimes)
end

function event_diff(event::Number, eventTimes::Array{<:Number, 1})
    subEvents = eventTimes[eventTimes .< event]
    event .- subEvents
end
