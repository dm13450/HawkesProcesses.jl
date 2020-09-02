
@testset "Event Probabilities" begin 

    @testset "Basic Test" begin 

        bg = 0.5
        kappa = 0.5
        kern = Distributions.Exponential(1/0.5)
        events = [1,2,3]
        startT = 4
        endT = 5
        prob = HawkesProcesses.event_probability(startT, endT, events, bg, kappa, kern)
        @test isa(prob, Number)
    end

    @testset "Value Test" begin 
        bg = 0.5
        kappa = 0.5
        kern = Distributions.Exponential(1/0.5)
        events = [1,2,3]
        startT = 400
        endT = 500
        prob = HawkesProcesses.event_probability(startT, endT, events, bg, kappa, kern)
        @test prob == 50
    end

end