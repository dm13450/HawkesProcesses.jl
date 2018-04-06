function parentSample(eventsDiffMatrix, baseRate, kappa, kernel)

    n = size(eventsDiffMatrix, 2)
    
    parentSampleVector = Array{Int}(n)
    
    for i=1:n
        parentSampleVector[i] = parentSampleCol(eventsDiffMatrix[:,i], baseRate, kappa, kernel)
    end
    
    return(parentSampleVector)
end


function parentSampleCol(eventsDiffMatrixCol, baseRate, kappa, kernel)
    
    childProb = kappa*kernel(eventsDiffMatrixCol[2:end])
    sampleWeights = StatsBase.Weights(unshift!(childProb, baseRate))
    StatsBase.sample(sampleWeights) - 1
    
end


function parentSampleCol(eventsDiffMatrixCol, baseRate::Function, kappa, kernel)
    
    backgroundProb = baseRate(eventsDiffMatrixCol[1])
    parentSampleCol(eventsDiffMatrixCol, backgroundProb, kappa, kernel)
end
