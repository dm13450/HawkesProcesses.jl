@testset "Compensator" begin

    bg = 0.5
    kappa = 0.5
    kernD = Distributions.Exponential(1/0.5)
    events = sort(rand(10))

    testval = HawkesProcesses.compensator(events[1], events, bg, kappa, kernD)

    @test length(testval) == 1

    inferTests && @inferred HawkesProcesses.compensator(events[1], events, bg, kappa, kernD)

end