using HawkesProcesses
using Test

nEvents = 10

testEventTimes = cumsum(rand(nEvents))

testDiff = HawkesProcesses.eventDifferenceMatrix(testEventTimes)

#@test isa(testDiff, Array) Need to clear up typing
@test size(testDiff) == (nEvents + 1, nEvents)
