function likelihood(events, background::Float64, kappa::Float64, kernel::Distributions.Distribution, maxT::Number)
    kernel_f, kernel_cdf = generate_kernel_functions(kernel)
    likelihood(events, background, kappa, kernel_f, kernel_cdf, maxT)
end


function likelihood(events, background::Float64, kappa::Float64, kernel::Function, kernel_cdf::Function, maxT::Number)

    logIntensitySum = sum(log.(intensity(events, events, background, kappa, kernel)))
    backgroundIntegral = background * maxT
    kernelIntegral = sum(kernel_cdf(maxT .- events))

    logIntensitySum - backgroundIntegral - kappa*kernelIntegral
end
