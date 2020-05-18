"""

Calculate the parent probabilites of each event.

"""
function parent_probs(eventtimes::Array{<:Number, 1}, bg, kappa::Float64, kern::Function)
    eventdifferencelist = event_difference_list(eventtimes)
    parent_probs(eventtimes, bg, kappa, kern, eventdifferencelist)
end

function parent_probs(eventtimes::Array{<:Number, 1}, bg, kappa::Float64, kern::Function, eventdifferencelist)
    parentprobs = Array{Array{Float64, 1}}(undef, length(eventtimes))
    for i in 1:length(eventtimes)
        parentprobs[i] = event_parent_prob(eventtimes[i], bg, kappa, kern, eventdifferencelist[i])
    end
    return parentprobs
end

function event_parent_prob(eventtime::Number, bg::Number, kappa::Float64, kern::Function, eventdifference::Array{<:Number, 1})
    probs = Array{Float64, 1}(undef, length(eventdifference) + 1)
    probs[1] = bg
    probs[2:end] .= kappa * kern(eventdifference)
    probs
end

function event_parent_prob(eventtime::Number, bg::Function, kappa::Float64, kern::Function, eventdifference::Array{<:Number, 1})
    event_parent_prob(eventtime, bg(eventtime), kappa, kern, eventdifference)
end
