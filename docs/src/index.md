# HawkesProcesses.jl

```@meta
CurrentModule=HawkesProcesses
```

```@contents
Pages = ["simulating.md"]
Depth = 1
```

## Functions

```@docs
fit(events::Array{<:Number, 1}, maxT::Number, its::Int64)
hierarchical_fit(eventTimesList, maxT::Number, its::Int64)
intensity(ts::Array{<:Number, 1}, events::Array{<:Number, 1}, background, kappa::Float64, kernel::Function)
compensator(ts::Number, events::Array{<:Number}, bg::Number, kappa::Number, kern::Distributions.Distribution)
simulate(bg, kappa::Float64, kern::Function, maxT::Number)
likelihood(events::Array{<:Number, 1}, background::Float64, kappa::Float64, kernel::Distributions.Distribution, maxT::Number)
time_change_null(events::Array{<:Number}, maxT::Number)
time_change_hawkes(events::Array{<:Number}, bg::Number, kappa::Number, kern::Distributions.Distribution)
```

## Index

```@index
```