

function time_change_null(events::Array{<:Number}, maxT::Number)
    rate = length(events) / maxT
    Lambda = rate .* events
    _time_change(Lambda)
end

function time_change_hawkes(events::Array{<:Number}, bg::Number, kappa::Number, kern::Distributions.Distribution)

    Lambda = Array{Float64, 1}(undef, length(events))

    for (i, event) in enumerate(events)
        Lambda[i] = compensator(event, events, bg, kappa, kern)
    end
    
    _time_change(Lambda)
end

function _time_change(Lambda::Array{<:Number})

    tau = diff(Lambda)

    u = 1 .- exp.(-tau)
    b = (collect(1:length(u)) .- 0.5) / length(u)

    return (b, sort(u))
end
