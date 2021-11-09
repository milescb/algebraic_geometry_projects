using ForwardDiff, Calculus

## Function used in finding solutions to polynomial equations in more than one variable
## See newton_method.ipynb for explanation of model
function newton_solve(start::Vector, Func::Function, tolerance::Float64 = 1.0e-15)

    #evaluate initial point
    tol = Func(start...)

    #check if initial point is solution
    not_minimized = true
    if tol == zeros(length(tol))
        not_minimized = false
    end

    #save steps taken by algorithm
    steps_x = [start[1]]
    steps_y = [start[2]]
    
    i = 0
    while (not_minimized && i < 501)
        #test for convergence 
        if i == 500
            error("Algorithm did not converge!")
        end

        #solve linear system
        J = ForwardDiff.jacobian(x->Func(x...), start)
        start_new = J \ -Func(start...)

        #update values
        for i in 1:length(start)
            start[i] = start_new[i] + start[i]
        end
        tol = Func(start...)

        #test if tolerance is reached
        not_minimized = false
        for i in 1:length(tol)
            if abs(tol[i]) > tolerance
                not_minimized = true
            end
        end

        #append steps taken in first two variables 
        append!(steps_x, start[1])
        append!(steps_y, start[2])
        i += 1
    end

    return start, steps_x, steps_y
end

## function used for finding roots of equations
## see newton_1d.ipynb for explanation of model
function newton_1d(StartPoint::Float64, Func::Function, tolerance::Float64 = 1e-15)
    
    start = StartPoint
    tol = Func(start)
    steps = [start]

    i = 0
    while (abs(tol) > tolerance && i < 501)
        #test for convergence
        if i == 500
            error("Algorithm did not converge!")
        end

        #implement method
        start = start - Func(start) / derivative(Func, start)
        tol = Func(start)

        #append steps
        append!(steps, start)
        i += 1
    end
    
    return start, steps
end