using HawkesProcess, Base.Test

testEventTimes = cumsum(rand(50))

testDiff = HawkesProcess.eventDifferenceMatrix(testEventTimes)

@test isa(testDiff, Array)
