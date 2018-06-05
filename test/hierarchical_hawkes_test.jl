using HawkesProcess, Base.Test

testEvents = [sort(rand(100)*100), sort(rand(100)*100)]

testSamples = HawkesProcess.HierarchicalHawkesFit(testEvents, 100, 3)

@test isa(testSamples, Tuple)
@test length(testSamples) == 3
@test size(testSamples[1]) == (3,)
@test size(testSamples[2]) == (3,)
@test size(testSamples[3]) == (3,)
