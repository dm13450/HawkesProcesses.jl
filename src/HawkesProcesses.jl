module HawkesProcesses

    using Distributions
    using StatsBase

    include("sample_parents.jl")
    include("event_difference.jl")
    include("parent_probabilites.jl")
    include("all_constant_hawkes.jl")
    include("hierarchical_all_constant.jl")
    include("simulate.jl")
    include("intensity.jl")
    include("likelihood.jl")
    include("time_change.jl")
    include("compensator.jl")
    include("utils.jl")
    include("event_probability.jl")
    include("simulate_forward.jl")

    export fit, hierarchical_fit, 
    intensity, compensator,
    likelihood,
    simulate, simulate_forward

end # module
