using HawkesProcesses
using Distributions
using Test

inferTests = false

my_tests = ["count_event_test.jl",
            "event_difference_matrix_test.jl",
            "parent_sample_test.jl",
            "all_constant_hawkes_test.jl",
            "simulate_test.jl",
            "intensity_test.jl"]

println("Running tests: ")

for test in my_tests
    include(test)
end
