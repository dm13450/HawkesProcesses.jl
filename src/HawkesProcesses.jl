module HawkesProcesses

    #using Distributions
    #using StatsBase

    include("parent_sample.jl")
    include("event_difference_matrix.jl")
    include("count_event.jl")
    include("all_constant_hawkes.jl")
    include("hierarchical_all_constant.jl")
    include("simulate.jl")
    #include("dirichlet_background_hawkes.jl")

    export HawkesFit, HierarchicalHawkesFit

end # module
