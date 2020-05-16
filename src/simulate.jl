
function simulate(bg::Number, kappa::Float64, kern::Function, maxT::Number)

    childfunction(x) = kappa * kern(x)
    lambda_max = childfunction(0)
    backgroundEvents = poisson_simulation(bg, maxT)

    eventbus = backgroundEvents
    allevents = backgroundEvents

    while !isempty(eventbus)
        simevent = popfirst!(eventbus)
        newevents = poisson_simulation(childfunction, maxT - simevent, lambda_max)
        append!(eventbus, newevents)
        if !isempty(newevents)
            append!(allevents, newevents .+ simevent)
        end
    end
    allevents
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

function poissson_simulation(rate::Function, maxT::Number, lambda_max::Number)
    tstar = poisson_simulation(lambda_max, maxT)
    accept_prob = rate(tstar) / lambda_max
    tstar[rand(length(accept_prob)) .< accept_prob]
end