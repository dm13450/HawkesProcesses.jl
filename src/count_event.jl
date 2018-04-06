function countEvent(parentVector, eventTimes)

    n = size(parentVector, 1)
    numBackgroundEvents = 0
    childEventsVector = zeros(parentVector)
    childShiftTime = zeros(parentVector, Float64)
    
    for i=1:n
        if parentVector[i]==0
            numBackgroundEvents += 1
            continue
         end
            
        childEventsVector[i] +=1

        childShiftTime[i] = eventTimes[i] - eventTimes[parentVector[i]] 
    end
    numBackgroundEvents, childEventsVector, childShiftTime[childShiftTime .!= 0]
end
