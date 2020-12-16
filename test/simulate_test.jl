using Distributions

@testset "Simulate" begin

    @testset "Poisson Simulation" begin
        inferTests && @inferred HawkesProcesses.poisson_simulation(0.5, 10)
        inferTests && @inferred HawkesProcesses.poisson_simulation(x->x, 10)
    end
    @testset "Hawkes Simulation with Kernel Function" begin
        kern(x) = pdf.(Distributions.Exponential(1/0.5), x)
        testevents = HawkesProcesses.simulate(0.5, 0.5, kern, 10)

        @test length(testevents) > 0
        inferTests && @inferred HawkesProcesses.simulate(0.5, 0.5, kern, 100)
    end

    @testset "Hawkes Simulation with Distribution" begin
        kernD = Distributions.Exponential(1/0.5)
        testevents = HawkesProcesses.simulate(0.5, 0.5, kernD, 10)

        @test length(testevents) > 0
        inferTests && @inferred HawkesProcesses.simulate(0.5, 0.5, kernD, 100)
    end

    @testset "Hawkes Simulation with function background" begin
        kernD = Distributions.Exponential(1/0.5)
        testevents = HawkesProcesses.simulate(x-> 0.5*x, 0.5, kernD, 10)
        @test length(testevents) > 0
    end


end
