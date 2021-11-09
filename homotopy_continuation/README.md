# Using Homotopy Continuation to solve systems of equations

We use method of Homotopy Continuation to solve systems of equations. An explanation of the method used can be found in the `.pdf` file. To use the functions discussed here download `homotopy.jl` and then do 

```julia
include("homotopy.jl"). 
```

One example is included in this file. To see this in progress, uncomment the code at the end of the file. Note that to solve other systems in more variables / larger systems, both `path_track()` and `homotopy_solve()` need to be modified appropriately. 

Finally, note that `HomotopyConinuation.jl` can be used to solve any polynomial system without any modification... so maybe just use that. This is more of an exercise in understanding how these concepts work. 
