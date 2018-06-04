using HawkesProcess
using Base.Test

# write your own tests here

println("Starting Tests")

@time @testset "Event Differnence Matrix Tests" begin include("event_difference_matrix_test.jl") end
@time @testset "Parent Sample Column Test" begin include("parent_sample_test.jl") end
@time @testset "Event Counts Test" begin include("count_event_test.jl") end
@time @testset "Basic Hawkes Fit Test" begin include("all_constant_hawkes_test.jl") end
@time @testset "Dirichlet Backgound  Hawkes Fit Test" begin include("dirichlet_background_hawkes_test.jl") end
@time @testset "Hierarchical Hawkes Fit Test" begin include("hierarchical_hawkes_test.jl") end
