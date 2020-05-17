
@testset "Intensity" begin


    @testset "Constant Intensity" begin
        bg = 0.5
        kappa = 0.5
        kern(x) = pdf.(Distributions.Exponential(1/0.5), x)
        testEvents = [1, 2, 3]
        inferTests && @inferred HawkesProcesses.intensity(0, testEvents, bg, kappa, kern)
        @test HawkesProcesses.intensity(0, testEvents, bg, kappa, kern) == bg
        @test HawkesProcesses.intensity(1, testEvents, bg, kappa, kern) == bg
        @test HawkesProcesses.intensity(1000, testEvents, bg, kappa, kern) == bg
        @test HawkesProcesses.intensity([0, 1000], testEvents, bg, kappa, kern) == [bg, bg]
        @test HawkesProcesses.intensity(testEvents, testEvents, bg, kappa, kern) ≈ [bg, bg + kappa * kern(1), bg + kappa * kern(1) + kappa * kern(2)] atol=0.01
    end


end
