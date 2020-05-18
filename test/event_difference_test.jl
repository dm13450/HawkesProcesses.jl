
@testset "Event Difference" begin
    testEvent = 3
    testEventTimes = [1, 2, 3]
    @testset "Individual" begin
        inferTests && @inferred HawkesProcesses.event_diff(testEvent, testEventTimes)
        @test HawkesProcesses.event_diff(3, testEventTimes) == [2, 1]
        @test HawkesProcesses.event_diff(2, testEventTimes) == [1]
        @test HawkesProcesses.event_diff(1, testEventTimes) == []
    end
    @testset "Full Array" begin
        testEventTimes = [1,2,3]
        @test HawkesProcesses.event_difference_list(testEventTimes) == [[], [1], [2, 1]]
    end
end
