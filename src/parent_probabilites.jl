"""

Calculate the parent probabilites of each event.

    parent_probs(events, bg, kappa, kern)

# Arguments

* events Array of event times.
* bg Background intensity
* kappa Child excitation parameter.
* kern Kernel decay function

# Examples

```julia
kern_f(x) = pdf.(Distributions.Exponential(1/0.5), x)
parent_probs([1,2,3], 0.5, 0.5, )
```

"""
function parent_probs(events::Array{<:Number, 1}, bg, kappa::Float64, kern::Function)
    eventdifferencelist = event_difference_list(events)
    parent_probs(events, bg, kappa, kern, eventdifferencelist)
end

function parent_probs(events::Array{<:Number, 1}, bg, kappa::Float64, kern::Function, eventdifferencelist)
    parentprobs = Array{Array{Float64, 1}}(undef, length(events))
    for i in 1:length(events)
        parentprobs[i] = event_parent_prob(events[i], bg, kappa, kern, eventdifferencelist[i])
    end
    return parentprobs
end

function event_parent_prob(event::Number, bg::Number, kappa::Float64, kern::Function, eventdifference::Array{<:Number, 1})
    probs = Array{Float64, 1}(undef, length(eventdifference) + 1)
    probs[1] = bg
    probs[2:end] .= kappa * kern(eventdifference)
    probs
end

function event_parent_prob(event::Number, bg::Function, kappa::Float64, kern::Function, eventdifference::Array{<:Number, 1})
    event_parent_prob(event, bg(event), kappa, kern, eventdifference)
end
