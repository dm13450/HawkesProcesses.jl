
"""
    simulate_forward

Simulate a Hawkes process given we have already observed some events. This can be used to forecast future events. 

# Arguments
* `eventHistory`
* `maxT` Maximum time value to simulate forward to.
* `startT` Starting time from which to simulate forward. 
* `bg` Background value
* `kappa` Kappa value
* `kern` Kernel function or distribution

"""
function simulate_forward(eventHistory, maxT::Number, startT::Number, bg::Number, kappa::Number, kern::Function)

    bgF(x) = intensity(collect(x .+ startT), eventHistory, bg, kappa, kern)
    events = simulate(bgF, kappa, kern, maxT)
    events .+ startT

end

function simulate_forward(eventHistory, maxT::Number, startT::Number, bg::Number, kappa::Number, kern::Distribution)
    kernD, kern_cdf = generate_kernel_functions(kern)
    simulate_forward(eventHistory, maxT, startT, bg, kappa, kernD)
end