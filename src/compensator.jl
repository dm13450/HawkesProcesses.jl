function compensator(ts::Number, events::Array{<:Number}, bg::Number, kappa::Number, kern::Distributions.Distribution)
    bg * ts + kappa * sum(Distributions.cdf.(kern, ts .- events[events .< ts]))
end