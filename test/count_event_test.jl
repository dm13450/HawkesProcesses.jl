using HawkesProcess, Base.Test, Distributions

testEventTimes = [1,2,3]
testParentVector = [0,1,0]


testCountEvents = HawkesProcess.countEvent(testParentVector, testEventTimes)

@test isa(testCountEvents, Tuple)
@test length(testCountEvents) == 3
@test testCountEvents[1] == 2
@test testCountEvents[2] == [1,0,0]
@test testCountEvents[3] == [1]



testCountEvents_nochildren = HawkesProcess.countEvent([0,0,0], testEventTimes)

@test isa(testCountEvents_nochildren, Tuple)
@test length(testCountEvents_nochildren) == 3
@test testCountEvents_nochildren[1] == 3
@test testCountEvents_nochildren[2] == [0,0,0]
@test isempty(testCountEvents_nochildren[3])






