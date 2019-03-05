using StatsBase

function parentSample(eventsDiffMatrix, baseRate, kappa, kernel)

    n = size(eventsDiffMatrix, 2)

    parentSampleVector = Array{Int}(undef, n)

    for i=1:n
        parentSampleVector[i] = parentSampleCol(view(eventsDiffMatrix, :,i),
                                                baseRate,
                                                kappa,
                                                kernel)
    end

    return(parentSampleVector)
end


function parentSampleCol(eventsDiffMatrixCol, baseRate::Float64, kappa, kernel)

    childProb::Array{Float64, 1} = kappa*kernel(eventsDiffMatrixCol[2:end])
    sampleWeights = StatsBase.Weights(pushfirst!(childProb, baseRate))
    StatsBase.sample(sampleWeights) - 1

end


function parentSampleCol(eventsDiffMatrixCol, baseRate::Function, kappa, kernel)

    backgroundProb = baseRate(eventsDiffMatrixCol[1])
    parentSampleCol(eventsDiffMatrixCol, backgroundProb, kappa, kernel)
end
