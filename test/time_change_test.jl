@testset "Null Time Change" begin

    testEvents = sort(rand(100)*100)
    null = HawkesProcesses.time_change_null(testEvents, 100)

    @test length(null) == 2
    inferTests && @inferred HawkesProcesses.time_change_null(testEvents, 100)

end

@testset "Hawkes Time Change" begin
    bg = 0.5
    kappa = 0.5
    kernD = Distributions.Exponential(1/0.5)
    events = sort(rand(10))

    res = HawkesProcesses.time_change_hawkes(events, bg, kappa, kernD)
    @test length(res) == 2
    inferTests && @inferred HawkesProcesses.time_change_hawkes(events, bg, kappa, kernD)

end

@testset "Internal Function" begin
    
    res = HawkesProcesses._time_change(sort(rand(100)))

    @test length(res) == 2
    inferTests && @inferred HawkesProcesses._time_change(sort(rand(100)))

end