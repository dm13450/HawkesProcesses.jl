using HawkesProcess, Base.Test, Distributions

testEvents = sort(rand(100)*100)

testBGSamples = HawkesProcess.HawkesFit(testEvents, 100, 3)

@test isa(testBGSamples, Tuple)
@test length(testBGSamples) == 3
@test size(testBGSamples[1]) == (3,)
@test size(testBGSamples[2]) == (3,)
@test size(testBGSamples[3]) == (3,)



