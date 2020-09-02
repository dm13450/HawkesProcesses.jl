"""
    compensator(ts::Number, events::Array{<:Number}, bg::Number, kappa::Number, kern::Distributions.Distribution)

The compensator or integrated intensity function. 

# Arguments

* `ts::Number` time to which evaluate the integrated intensity function. 
* `events::Array{<:Number}` events from the intensity function. 
* `bg::Number` Background rate. 
* `kappa::Number` Kappa parameter
* `kern::Distributions.Distribution` Distribution of the kernel. 

# Examples


"""
function compensator(ts::Number, events::Array{<:Number}, bg::Number, kappa::Number, kern::Distributions.Distribution)
    bg * ts + kappa * sum(Distributions.cdf.(kern, ts .- events[events .< ts]))
end