using Test

@testset "Hierarchical Sampling" begin

maxT = 100
nSamples = 10
its = 5000

testEvents = Array{Array{Float64}}(undef, nSamples)
for i in 1:nSamples
    testEvents[i] = HawkesProcesses.simulate(0.5, 0.5, Distributions.Exponential(1/0.5), maxT)
end

testSamples = HawkesProcesses.hierarchical_fit(testEvents, maxT, its)

@test isa(testSamples, Tuple)
@test length(testSamples) == 3
@test length(testSamples[1]) == its
@test length(testSamples[2]) == its
@test length(testSamples[3]) == its

end