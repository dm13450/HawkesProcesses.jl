using Distributions

@testset "Simulate" begin

    @testset "Poisson Simulation" begin
        @inferred HawkesProcesses.poisson_simulation(0.5, 10)
        @inferred HawkesProcesses.poisson_simulation(x->x, 10)
    end
    @testset "Hawkes Simulation" begin
        kern(x) = pdf.(Distributions.Exponential(1/0.5), x)
        #@inferred HawkesProcesses.simulate(0.5, 0.5, kern, 100)
    end

end