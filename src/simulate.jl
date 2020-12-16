"""
    simulate(bg::Number, kappa::Float64, kern::Function, maxT::Number)

Simulate a Hawkes process between 0 and `maxT` with parameters `bg`, `kappa`, `kern`.

# Arguments

* `bg`: The background rate of the Hawkes process. Constant or positive function. 
* `kappa`: The kappa parameter of the Hawkes process.
* `kern` : The kernel function of the Hawkes process.
* `maxT` : Maximum time that the Hawkes process will be simulated for.

# Notes

* kappa must be between 0 and 1 for a stable Hawkes process.

# Examples

``julia
kern_f(x) = pdf.(Distributions.Exponential(1/0.5), x)

simevents = simulate(0.5, 0.5, kern_f, 100)
``

"""
function simulate(bg, kappa::Float64, kern::Function, maxT::Number)

    childfunction(x) = kappa * kern(x)
    lambda_max = childfunction(0)
    childsimulation(x) = poisson_simulation(childfunction, maxT - x, lambda_max) .+ x

    backgroundEvents = poisson_simulation(bg, maxT)

    eventbus = backgroundEvents
    allevents = backgroundEvents

    while !isempty(eventbus)
        newevents = map(childsimulation, eventbus)
        childevents = vcat(filter(!isempty, newevents)...)
        append!(allevents, childevents)
        eventbus = childevents
    end
    sort(allevents)
end

function simulate(bg, kappa::Float64, kernD::Distributions.Distribution, maxT::Number)
    kern, kern_cdf = generate_kernel_functions(kernD)
    return simulate(bg, kappa, kern, maxT)
end

function poisson_simulation(rate::Number, maxT::Number)
    nevents = rand(Distributions.Poisson(rate*maxT))
    event_times = sort(rand(Distributions.Uniform(0, maxT), nevents))
    return event_times
end

function poisson_simulation(rate::Function, maxT::Number)
    lambda_max = 1.1*maximum(rate(range(0, maxT, length=1000)))
    poisson_simulation(rate, maxT, lambda_max)
end

function poisson_simulation(rate::Function, maxT::Number, lambda_max::Number)
    tstar = poisson_simulation(lambda_max, maxT)
    accept_prob = rate(tstar) / lambda_max
    tstar[rand(length(accept_prob)) .< accept_prob]
end
