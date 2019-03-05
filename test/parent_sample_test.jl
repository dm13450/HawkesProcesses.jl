using Test
using Distributions

### Test Data
testEventTimes = cumsum(rand(50))
testDiff = HawkesProcesses.eventDifferenceMatrix(testEventTimes)
expObj = Exponential(0.5)
kernelTest(x) = pdf.(expObj, x)
bgFunction(x) = 0.5 * x

@testset "Parent Sample" begin

    @testset "Constant Background Rate" begin
        testParentSampleCol_constant = HawkesProcesses.parentSampleCol(testDiff[:,1], 0.5, 0.5, kernelTest)
        testParentSample_constant = HawkesProcesses.parentSample(testDiff, 0.5, 0.5, kernelTest)

        @test isa(testParentSampleCol_constant, Int64)
        @test isa(testParentSample_constant, Array)
        @test size(testParentSample_constant) == (50, )
    end

    @testset "Function Background Rate" begin

        testParentSampleCol_function = HawkesProcesses.parentSampleCol(testDiff[:,1], bgFunction, 0.5, kernelTest)
        testParentSample_function = HawkesProcesses.parentSample(testDiff, bgFunction, 0.5, kernelTest)

        @test isa(testParentSampleCol_function, Int64)
        @test isa(testParentSample_function, Array)
        @test size(testParentSample_function) == (50, )

    end

end



# testParentSample_hier = map( x -> HawkesProcesses.parentSample(x,
#                                                  0.5,
#                                                  0.5,
#                                                  kernelTest), (testDiff, testDiff))
#
# @test isa(testParentSample_hier, Tuple)
# @test isa(testParentSample_hier[1], Array)
# @test isa(testParentSample_hier[2], Array)
# @test length(testParentSample_hier) == 2
