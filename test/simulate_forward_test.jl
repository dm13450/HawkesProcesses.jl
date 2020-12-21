@testset "Simulate Foward" begin

    @testset "Simulate Forward - Kernel Function" begin
        kern(x) = pdf(Distributions.Exponential(1/0.5), x)
        forwardEvents = HawkesProcesses.simulate_forward([5, 9], 20, 10, 0.5, 0.5, kern)
        @test length(fowardEvents) >= 0
    end

    @testset "Simulate Forward - Kernel Distribution" begin
        kernD = Distributions.Exponential(1/0.5)
        forwardEvents = HawkesProcesses.simulate_forward([5, 9], 20, 10, 0.5, 0.5, kernD)
        @test length(fowardEvents) >= 0
    end

end
