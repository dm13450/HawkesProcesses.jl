"""
    event_probability(startT, endT, events, background, kappa, kernel)
Forecast the probability of an event in defined time window. 

# Arguments
* `startT::Number`: Left boundary of the forecasting window.
* `endT::Number`: Right boundary of the forecasting window.  
* `events::Array{<:Number,1}`: Observed events
* `background`: Background rate
* `kappa::Float64`: Kappa value
* `kernel::Distribution`: Kernel distribution

# Notes
* As we are integregating the intensity function on a constant background, constant kappa and distriubtion for the kernel are supported. 

"""

function event_probability(startT::Number, endT::Number, events::Array{<:Number}, background::Number, kappa::Number, kernel::Distribution)

    filter!(x-> x <= endT, events)
    background*(endT - startT) + kappa * sum( cdf.(kernel, endT .- events) .- cdf.(kernel, startT .- events) )

end