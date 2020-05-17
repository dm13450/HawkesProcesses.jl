
@testset "Hawkes Fit" begin

    testEvents = sort(rand(100)*100)

    testSamples = HawkesProcesses.HawkesFit(testEvents, 100, 3)
    inferTests && @inferred HawkesProcesses.HawkesFit(testEvents, 100, 3)
    @test isa(testSamples, Tuple)
    @test length(testSamples) == 3
    @test size(testSamples[1]) == (3,)
    @test size(testSamples[2]) == (3,)
    @test size(testSamples[3]) == (3,)

end
