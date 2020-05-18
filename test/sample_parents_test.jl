
@testset "Sample Parents" begin

    expObj = Exponential(0.5)
    kernelTest(x) = pdf.(expObj, x)
    bgFunction(x) = 0.5 * x

    @testset "Constant Background Rate" begin
        inferTests && @inferred HawkesProcesses.sample_parents([1,2,3], 0.5, 0.5, kernelTest)

    end

    @testset "Function Background Rate" begin


    end


end
