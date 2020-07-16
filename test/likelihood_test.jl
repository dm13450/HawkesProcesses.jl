
@testset "Likelihood" begin

    kernD = Distributions.Exponential(1/0.5)
    bg = 0.5
    kappa = 0.5 
    l = HawkesProcesses.likelihood(sort(rand(10)), bg, kappa, kernD, 1)

    @test length(l) == 1
    inferTests && @inferred HawkesProcesses.likelihood(sort(rand(10)), bg, kappa, kernD, 1)
end