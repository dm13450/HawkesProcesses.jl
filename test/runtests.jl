using HawkesProcesses
using Distributions
using Test

inferTests = Bool(Int(get(ENV, "INFER_TESTS", "1")))

my_tests = ["event_difference_test.jl",
            "parent_probabilites_test.jl",
            "sample_parents_test.jl",
            "all_constant_hawkes_test.jl",
            "simulate_test.jl",
            "intensity_test.jl",
            "compensator_test.jl",
            "time_change_test.jl",
            "likelihood_test.jl",
            "test_utils.jl"]

println("Running tests: ")

@testset "HawkesProcesses.jl" begin
    for test in my_tests
        include(test)
    end
end