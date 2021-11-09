# Exploring the Newton-Ralphson Method

We implement a method for solving systems of equations using the Newton-Ralphson method. The functions for this implementation can be found in the `NewtonMethodFunctions.jl` file. A description of the usage and some examples can be found in `newton_method.pdf` and a file with these examples is inclucde in `project.ipynb`. Finally, `newton_1d.ipynb` includes an implementation for the single variable case, i.e. an implementation for finding roots of polynomials. 

To use the functions here, download `NewtonMethodFunctions.jl` and simply include this file in your project by 

```julia
include("NewtonMethodFunctions.jl")
```

To implement either function, you must construct a function that is an array of the equations you want to solve and give an initial point. This can be done as follows

```julia
f(x, y) = [8*x^3 + 2*y^2 - 2*x, 4*y^3 + 4*x*y - (2/3)*y]
p = randn(2)
p_sol, steps_x, steps_y = newton_solve(p, f)
```

To find more solutions, change the starting point! The tolerance can also be specified by providing an additional argumenent to the function as in 

```julia
p_sol, steps_x, steps_y = newton_solve(p, f, 1e-20)
```
