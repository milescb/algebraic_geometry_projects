# Implementing Homotopy Continuation
# Author: Miles Cochran-Branon
# Date: 11/9/21
# For additional information see `homotopy_continuation.pdf`. 

using HomotopyContinuation

#make one Euler step; solving system of ODEs using Euler method
function euler_step(H::System, Δt::Float64, x::Vector, t::Float64)
    
    #make four element Vector
    xt = append!(x, t)

    #get indices for vector subsetting
    index = []
    for i in 2:length(x)
        append!(index, i)
    end

    #make jacobian and separate out dH/dx and dH/dt
    J = jacobian(H, xt)
    ∂H∂x = J[:,index]
    ∂H∂t = J[:,1]

    #set up system and solve for Δx
    Δx = ∂H∂x \ -(∂H∂t * Δt)

    #update values for x and t
    x = xt[index .- 1] + Δx
    t = t + Δt

    return x, t

end

# make correction using Newton-Ralphson method
# general method that works for any system and can accept complex numbers. 
function newton_solve(start::Vector, F::System, tolerance::Float64 = 1e-15)

    #evaluate initial point
    tol = evaluate(F, start)

    #check if initial point is solution
    not_minimized = true
    if tol == zeros(length(tol))
        not_minimized = false
    end
    
    i = 0
    while (not_minimized && i < 501)
        #test for convergence 
        if i == 500
            error("Algorithm did not converge!")
        end

        #solve linear system
        J = jacobian(F, start)
        start_new = J \ -evaluate(F, start)

        #update values
        for i in 1:length(start)
            start[i] = start_new[i] + start[i]
        end
        tol = evaluate(F, start)

        #test if tolerance is reached
        not_minimized = false
        for i in 1:length(tol)
            if abs(tol[i]) > tolerance
                not_minimized = true
            end
        end
        i += 1
    end

    return start
end

#perform the Algorithm for one starting point
function path_track(H::System, start::Vector, Δt::Float64)

    time = 0.0
    tot_steps = 1 / Δt

    i = 0
    while i < tot_steps
        start, time = euler_step(H, Δt, start, time)
        # works only in case of two variables x and y. 
        # can modify easily by slightly changing the code below. 
        start = newton_solve(start, System(evaluate(H, [time, x, y])), 1e-12)
        i += 1
    end

    return start; 
end

#go over all starting points
function homotopy_solve(H::System)

    #set time step
    Δt = 0.001

    #open array for appending solutions
    solutions = []

    #compute all solutions
    #this only works for two equations which have degrees of 6 and 3 respectively 
    #can change easily by modifying indices in the ranges for i and j below. 
    for i in 0:5
        for j in 0:2
            start = [exp(i*im*2*π/6), exp(j*im*2*π/3)]
            sol = path_track(H, start, Δt)
            push!(solutions, sol)
        end
    end

    return solutions

end

#-------------------------------------------------------------------------------
# Example problem! Solve the system 
#
#                   f1(x, y) = (x^4 + y^4 - 1) * (x^2 + y^2 - 2) + x^5 * y
#                   f2(x, y) = (x^2 + 2*x*y^2 - 2*y^2 - 1/2)
#
# Uncomment following code if you wish to see an example of implementing this 
# method. 

# #define variables
# @var x y t 
# #input functions, manually make Homotopy
# fg1 = ((x^4 + y^4 - 1) * (x^2 + y^2 - 2) + x^5 * y) * t + (1 - t) * (x^6 - 1)
# fg2 = (x^2 + 2*x*y^2 - 2*y^2 - 1/2) * t + (1 - t) * (y^3 - 1)
# #make system
# H = System([fg1, fg2])

# solution = homotopy_solve(H)

