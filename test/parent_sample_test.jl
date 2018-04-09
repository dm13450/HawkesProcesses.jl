using HawkesProcess, Base.Test, Distributions

testEventTimes = cumsum(rand(50))
testDiff = HawkesProcess.eventDifferenceMatrix(testEventTimes)

expObj = Exponential(0.5)
kernelTest(x) = pdf.(expObj, x)
bgFunction(x) = 0.5 * x

testParentSampleCol_constant = HawkesProcess.parentSampleCol(testDiff[:,1], 0.5, 0.5, kernelTest)
testParentSampleCol_function = HawkesProcess.parentSampleCol(testDiff[:,1], bgFunction, 0.5, kernelTest)

testParentSample_constant = HawkesProcess.parentSample(testDiff, 0.5, 0.5, kernelTest)
testParentSample_function = HawkesProcess.parentSample(testDiff, bgFunction, 0.5, kernelTest)

@test isa(testParentSampleCol_constant, Int64)
@test isa(testParentSampleCol_function, Int64)

@test isa(testParentSample_constant, Array)
@test isa(testParentSample_function, Array)

@test size(testParentSample_constant) == (50, )
@test size(testParentSample_function) == (50, )




