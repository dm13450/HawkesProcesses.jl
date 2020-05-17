
## Can be made simpler/better by passing the background evaled through the function

function intensity(ts::Array{<:Number, 1}, events::Array{<:Number, 1}, background, kappa::Float64, kernel::Function)
  output = Array{Number, 1}(undef, length(ts))
  for (i, timestamp) in enumerate(ts)
    output[i] = intensity(timestamp, events, background, kappa, kernel)
  end
  return output
end

function intensity(ts::Number, events::Array{<:Number, 1},
                   background::Number, kappa::Float64, kernel::Function)
  bgContrib = background
  bgContrib + kernel_contribution(ts, events, kappa, kernel)
end

function intensity(ts::Number, events::Array{<:Number, 1},
                   background::Function, kappa::Float64, kernel::Function)
  bgContrib = background(ts)
  bgContrib + kernel_contribution(ts, events, kappa, kernel)
end

function kernel_contribution(ts::Number, events::Array{<:Number, 1}, kappa::Float64, kernel::Function)
  #kappa * sum( kernel.(ts .- events[events .< ts]))
  evalEvents = events[events .< ts]
  s = 0
  if !isempty(evalEvents)
    kernEval::Array{Number, 1} = kernel.(ts .- evalEvents)
    s = kappa * sum(kernEval)
  end
  return s
end
