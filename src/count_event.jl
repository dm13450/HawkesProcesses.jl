function countEvent(parentVector, eventTimes)

    n = size(parentVector, 1)
    numBackgroundEvents = 0
    childEventsVector = zeros(n)
    childShiftTime = zeros(n)

    for i=1:n
        if parentVector[i]==0
            numBackgroundEvents += 1
            continue
         end

        childEventsVector[parentVector[i]] +=1

        childShiftTime[i] = eventTimes[i] - eventTimes[parentVector[i]]
    end
    numBackgroundEvents, childEventsVector, childShiftTime[childShiftTime .!= 0]
end
