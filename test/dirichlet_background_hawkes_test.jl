
testEvents = sort(rand(100)*100)

testSamples = HawkesProcess.HawkesFitDirichletBackground(testEvents, 100, 2)

@test isa(testSamples, Tuple)
@test length(testSamples) == 4
