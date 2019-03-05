using HawkesProcesses
using Test

nEvents = 10

@testset "Event Difference Matrix" begin
    @testset "Basic" begin
        testEventTimes = cumsum(rand(nEvents))
        testDiff = HawkesProcesses.eventDifferenceMatrix(testEventTimes)
        @test size(testDiff) == (nEvents + 1, nEvents)
        #@test isa(testDiff, Array) Need to clear up typing
    end
end
