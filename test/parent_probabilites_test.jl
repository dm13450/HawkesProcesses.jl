
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

    @testset "Individual - Functional Background" begin
        inferTests && @inferred HawkesProcesses.event_parent_prob(3, x->0.5, kappa, kern, [1, 2])
        testProbs = HawkesProcesses.event_parent_prob(3, x->0.5, kappa, kern, [1, 2])
        @test length(testProbs) == 3
        @test testProbs[1] == 0.5
    end



    @testset "Full" begin
    
        inferTests && @inferred HawkesProcesses.parent_probs(sort(rand(100)), bg, kappa, kern)
        pp = HawkesProcesses.parent_probs(sort(rand(100)), bg, kappa, kern)

        @test length(pp) == 100

    end


end
