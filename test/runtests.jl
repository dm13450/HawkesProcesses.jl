using HawkesProcess
using Base.Test

# write your own tests here

println("Starting Tests")

@time @testset "Event Differnence Matrix Tests" begin include("event_difference_matrix_test.jl") end
