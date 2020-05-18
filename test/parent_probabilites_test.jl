
@testset "Parent Probabilities" begin
    bg = 0.5
    kappa = 0.5
    kern(x) = pdf.(Distributions.Exponential(1/0.5), x) 
    @testset "Individual" begin
        inferTests && @inferred HawkesProcesses.event_parent_prob(3, bg, kappa, kern, [1, 2])
        testProbs = HawkesProcesses.event_parent_prob(3, bg, kappa, kern, [1, 2])
        @test length(testProbs) == 3
        @test testProbs[1] == bg
    end


end
