"""
    fit(events::Array{<:Number, 1}, maxT::Number, its::Int64)

# Arguments

* `events` The array of event times to fit the Hawkes process too.
* `maxT` The boundary time over which the events were observed.
* `its` Number of iterations to sample for.

# Notes

* All `events` must be unique

"""
function fit(events::Array{<:Number, 1}, maxT::Number, its::Int64)
    _fit(events, maxT, its, update_constant_bg, update_constant_kappa, update_constant_exp_kernel)
end

function update_constant_bg(bgEvents, maxT)
    Distributions.rand(Distributions.Gamma(0.01 + length(bgEvents), 1/(0.01+1))) / maxT
end

function update_constant_kappa(childEvents, H_tilde)
    Distributions.rand(Distributions.Gamma(0.01 + sum(childEvents), 1/(0.01 + H_tilde)))
end

function update_constant_exp_kernel(shiftTimes)
    Distributions.rand(Distributions.Gamma(0.01 + length(shiftTimes), 1/(0.01 + sum(shiftTimes))))
end