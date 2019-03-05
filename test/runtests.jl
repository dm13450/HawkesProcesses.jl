using HawkesProcesses
using Test


my_tests = ["count_event_test.jl",
            "event_difference_matrix_test.jl",
            "parent_sample_test.jl"]

println("Running tests: ")

for test in my_tests
    include(test)
end
