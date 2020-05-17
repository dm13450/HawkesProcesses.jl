function generate_kernel_functions(dist::Distributions.Distribution)
    kernel(x) = pdf.(dist, x)
    kernel_int(x) = cdf.(dist, x)
    return kernel, kernel_int
end
