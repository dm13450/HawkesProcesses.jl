
@testset "Sample Parents" begin

    expObj = Exponential(0.5)
    kernelTest(x) = pdf.(expObj, x)
    bgFunction(x) = 0.5 * x

    @testset "Constant Background Rate" begin
        inferTests && @inferred HawkesProcesses.sample_parents([1,2,3], 0.5, 0.5, kernelTest)

        sp = HawkesProcesses.sample_parents([1,2,3], 0.5, 0.5, kernelTest)
        @test length(sp) == 4
        @test length(sp[1]) == 3
    end

    @testset "Function Background Rate" begin


    end


end
