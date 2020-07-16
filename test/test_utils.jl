@testset "Utility Tests" begin

    @testset "Kernel Generating Functions" begin 
        res = HawkesProcesses.generate_kernel_functions(Exponential())
        inferTests && @inferred HawkesProcesses.generate_kernel_functions(Exponential())
        @test length(res) == 2
    end

end