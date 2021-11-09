# Using Homotopy Continuation to solve systems of equations

We use method of Homotopy Continuation to solve systems of equations. An explanation of the method used can be found in the `.pdf` file. To use the functions discussed here download `homotopy.jl` and then do 

```julia
include("homotopy.jl"). 
```

One example is included in this file. To perform the example, uncomment the code at the end of the file and then run. 

```julia
#define variables
@var x y t 
#input functions, manually make Homotopy
fg1 = ((x^4 + y^4 - 1) * (x^2 + y^2 - 2) + x^5 * y) * t + (1 - t) * (x^6 - 1)
fg2 = (x^2 + 2*x*y^2 - 2*y^2 - 1/2) * t + (1 - t) * (y^3 - 1)
#make system
H = System([fg1, fg2])

solution = homotopy_solve(H)
```

Note that to solve other systems in more variables / larger systems, both `path_track()` and `homotopy_solve()` need to be modified appropriately. 

Finally, note that `HomotopyConinuation.jl` can be used to solve any polynomial system without any modification... so maybe just use that. This is more of an exercise in understanding how these concepts work. 
