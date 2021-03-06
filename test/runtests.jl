using HawkesProcesses
using Distributions
using Test

inferTests = Bool(parse(Int64, get(ENV, "INFER_TESTS", "0")))

my_tests = ["event_difference_test.jl",
            "parent_probabilites_test.jl",
            "sample_parents_test.jl",
            "all_constant_hawkes_test.jl",
            "simulate_test.jl",
            "intensity_test.jl",
            "compensator_test.jl",
            "time_change_test.jl",
            "likelihood_test.jl",
            "test_utils.jl",
            "event_probability_test.jl",
            "simulate_forward_test.jl",
            "hierarchical_hawkes_test.jl"]

println("Running tests: ")

@testset "HawkesProcesses.jl" begin
    for test in my_tests
        include(test)
    end
end