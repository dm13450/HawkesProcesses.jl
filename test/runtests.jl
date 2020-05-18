using HawkesProcesses
using Distributions
using Test

inferTests = false

my_tests = ["event_difference_test.jl",
            "parent_probabilites_test.jl",
            "sample_parents_test.jl",
            "all_constant_hawkes_test.jl",
            "simulate_test.jl",
            "intensity_test.jl"]

println("Running tests: ")

for test in my_tests
    include(test)
end
