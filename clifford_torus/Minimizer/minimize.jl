using GLMakie, DataFrames, CSV

#Initialize data frame
df = DataFrame(x1 = Float64[], x2 = Float64[], x3 = Float64[], x4 = Float64[], d = Float64[])

#Number of points in each interation of the torus
n = 100000000

#Point to minimize to
p = [10, 10, 8, 7]

#Function to find minimum 
function find_min(n, p)

    #Define vectors for input
    theta = (2 * pi) .* rand(n)
    phi = (2 * pi) .* rand(n)

    #Convert to cartesian coordinates
    x1 = [(1 / sqrt(2)) * cos(u) for u in theta]
    x2 = [(1 / sqrt(2)) * sin(u) for u in theta]
    x3 = [(1 / sqrt(2)) * cos(v) for v in phi]
    x4 = [(1 / sqrt(2)) * sin(v) for v in phi]

    d = Inf64
    min_point = Vector{Float64}(undef, 4)    

    #define distance
    for i in 1:n
        d_temp = sqrt((x1[i] - p[1])^2 + (x2[i] - p[2])^2 + (x3[i] - p[3])^2 + (x4[i] - p[4])^2)
        if (d_temp < d) 
            d = d_temp
            min_point = [x1[i], x2[i], x3[i], x4[i]]
        end;
    end;

    return min_point, d

end;

#Number of interations to perform and counter
counter = 0
num_interations = 10

while counter < num_interations

    #Call function to find min 
    local min_point, d = find_min(n, p)

    #Add value of min to data file
    push!(df, [min_point[1] min_point[2] min_point[3] min_point[4] d])
    global counter = counter + 1

end; 

#Write data to file
CSV.write("minimize_values.txt", df, header = false)